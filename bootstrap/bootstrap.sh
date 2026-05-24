#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="gitops-poc"

echo "GitOps bootstrap."

# Create cluster if not already present
if k3d cluster list | grep -q "$CLUSTER_NAME"; then
  echo "Cluster already exists."
else
  echo "Creating k3d cluster."
  k3d cluster create "$CLUSTER_NAME" -p "80:80@loadbalancer" -p "443:443@loadbalancer"
fi

# Install Flux
if kubectl get ns flux-system >/dev/null 2>&1; then
  echo "Flux already installed."
else
  echo "Installing Flux."
  flux install
fi

# Idempotent application
echo "Applying: GitRepository + Kustomization."

kubectl apply -f clusters/local/flux/gotk-sync.yaml

echo "Reconciling Flux."

flux reconcile source git flux -n flux-system || true
flux reconcile kustomization flux -n flux-system || true

echo "Bootstrap complete."