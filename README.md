# PCF to Kubernetes – Minimal Cloud-Native Demo

This project demonstrates how cloud-native application patterns commonly used in
Pivotal Cloud Foundry (PCF) map directly to Kubernetes and Infrastructure-as-Code
using Terraform.

The goal is to expose the underlying container orchestration and deployment mechanics
that PCF typically abstracts away.

---

## What This Project Shows

- Containerized application deployment using Docker
- Kubernetes-based orchestration (Deployment, Service, ConfigMap)
- Health checks and zero-downtime rolling updates
- Externalized configuration via environment variables
- Infrastructure-as-Code using Terraform with the Kubernetes provider

---

## Architecture Overview

- Application runs as a stateless container
- Kubernetes Deployment manages replicas and rolling updates
- Kubernetes Service provides stable networking
- Configuration is injected via ConfigMap
- All Kubernetes resources are managed declaratively via Terraform

---

## PCF to Kubernetes Concept Mapping

| PCF Concept            | Kubernetes Equivalent        |
|------------------------|------------------------------|
| cf push                | kubectl / Terraform apply    |
| Buildpacks             | Docker image build           |
| Health checks          | Liveness/Readiness probes   |
| App scaling            | Replica count                |
| Config vars            | ConfigMap / env vars         |
| Blue-green deployments | Rolling updates              |

---

## Prerequisites

- Docker
- Kubernetes (Minikube or kind)
- kubectl
- Terraform

---

## How to Run


1. Start Kubernetes
```bash
minikube start
