CLUSTER_NAME=gitops-poc

.PHONY: create status flux-logs reconcile vector-logs destroy

.DEFAULT_GOAL := help

help:
	@echo ""
	@echo "  make create: Create cluster + bootstrap Flux"
	@echo "  make status: Show Kubernetes + Flux status"
	@echo "  make flux-logs: Show Flux Controller logs"
	@echo "  make reconcile: Force Flux reconciliation"
	@echo "  make hello: Show hello-world app URL"
	@echo "  make vector-logs: Show Vector logs"
	@echo "  make destroy: Delete cluster"
	@echo ""

create:
	@bash bootstrap/bootstrap.sh
	@echo "Hello World app: http://hello.localhost"

status:
	@kubectl get all -A
	@kubectl get kustomizations -A
	@flux get all -A

flux-logs:
	@kubectl logs -n flux-system deploy/kustomize-controller

reconcile:
	@flux reconcile source git flux -n flux-system || true
	@flux reconcile kustomization flux -n flux-system || true

vector-logs:
	@kubectl logs -n vector -l app=vector -f

destroy:
	@echo "Deleting cluster."
	@k3d cluster delete $(CLUSTER_NAME)