# Introduction
The purpose of this project is to provide a mechanism for the setup of a Kubernetes-based environment based on GitOps principles.

# Repository Structure
The repository is structured as follows:
```
flux/
├── Makefile
├── README.md
├── apps
├── bootstrap
├── clusters
├── infrastructure
└── platform
``` 

- bootstrap: Cluster creation + Flux bootstrap
- clusters: Flux entrypoint
- apps: Application definitions
- platform: platform software (e.g., Vector, etc.)
- infrastructure : Cluster resources (e.g., namespaces, etc.)

# Technologies
- k3d: lightweight Kubernetes local cluster
- Flux: reconciliation
- Kubernetes: container orchestration

# Prerequisites (Software)
- Docker
- k3d
- kubectl
- Flux CLI
- make

# Cluster Bootstrap
Bootstraps the Kubernetes Cluster, Flux, and starts a hello world application. The link where it can be accessed will be provided in the output (e.g., http://hello.localhost).

```shell
Step 1: clone project locally
Step 2: cd flux
Step 3: make create
```

# Help
```shell
make create: Create cluster + bootstrap Flux
make status: Show Kubernetes + Flux status
make flux-logs: Show Flux Controller logs
make reconcile: Force Flux reconciliation
make hello: Show hello-world app URL
make vector-logs: Show Vector logs
make destroy: Delete cluster
```

# Log verification
```shell
make vector-logs
```
# Future
- Understand user needs
- Make the implementation more generic: parameterized, etc.
- Observability: Metrics, Distributed Tracing, etc.
- Durable medium for logs
- Service Mesh
- Dashboards for visibility: admin + engineering teams
- Tenant isolation: namespaces, quotas, security and RBAC rules for tenants, network isolation rules, etc.
- Scaling
- Helm
- Cloud Integration
- Multi-cluster setup Needed? If yes: Cluster API, etc.