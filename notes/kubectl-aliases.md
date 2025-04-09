# Kubectl Aliases and Functions

This document contains useful kubectl aliases and functions for CKAD exam preparation.

## Basic Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| k     | kubectl | Base kubectl command |
| kg    | kubectl get | Get resources |
| kd    | kubectl describe | Describe resources |
| ka    | kubectl apply -f | Apply configuration from file |
| kx    | kubectl exec -it | Execute command in container |

## Alias Usage Examples

### Basic Commands
```bash
# Get resources
kg pods
kg deployments
kg services

# Describe resources
kd pod nginx
kd deployment nginx-deployment
kd service nginx-service

# Apply configuration
ka deployment.yaml
ka -f config/

# Execute in container
kx nginx-pod -- /bin/bash
kx nginx-pod -c nginx-container -- /bin/sh
```

### Common Combinations
```bash
# Get with wide output
kg pods -o wide

# Get with specific namespace
kg pods -n my-namespace

# Get with labels
kg pods -l app=nginx

# Describe all resources
kd pods
kd services
```

## Functions

### kyaml
Generates YAML using `--dry-run=client` for quick resource creation.

#### Usage
```bash
kyaml <resource-type> <resource-name> [options]
```

#### Examples
```bash
# Generate Pod YAML
kyaml pod nginx --image=nginx

# Generate Deployment YAML
kyaml deployment nginx-deployment --image=nginx --replicas=3

# Generate Service YAML
kyaml service nginx-service --port=80 --target-port=8080

# Generate ConfigMap YAML
kyaml configmap game-config --from-literal=game.properties="enemies=aliens"

# Generate Secret YAML
kyaml secret generic db-secret --from-literal=username=admin --from-literal=password=secret
```

#### Common Options
```bash
# Pod options
kyaml pod nginx --image=nginx --port=80 --env="KEY=VALUE"

# Deployment options
kyaml deployment nginx --image=nginx --replicas=3 --port=80

# Service options
kyaml service nginx --port=80 --target-port=8080 --type=LoadBalancer

# With namespace
kyaml pod nginx --image=nginx -n my-namespace
```

## Tips for CKAD Exam
1. Use `kyaml` to quickly generate YAML templates
2. Combine aliases with common flags:
   - `-o wide` for more details
   - `-n` for namespace
   - `-l` for label selection
3. Use `kx` for quick container access
4. Remember `ka` for applying configurations
5. Use `kd` for troubleshooting 