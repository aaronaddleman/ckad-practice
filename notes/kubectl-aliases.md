# Kubectl Aliases and Functions

This document provides a comprehensive guide to the kubectl aliases and functions available for CKAD exam preparation.

## Basic Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `k` | `kubectl` | Main kubectl command shorthand |
| `kg` | `kubectl get` | Get resources |
| `kd` | `kubectl describe` | Describe resources |
| `ka` | `kubectl apply -f` | Apply resources from files |
| `kx` | `kubectl exec -it` | Execute commands in containers |
| `kdel` | `kubectl delete --now` | Delete resources immediately |

## YAML Generation Function (kyaml)

The `kyaml` function helps generate Kubernetes YAML manifests using `kubectl create --dry-run=client`. It supports multiple resource types and provides a consistent interface for generating YAML templates.

### Usage
```bash
kyaml <resource-type> <resource-name> [options]
```

### Supported Resource Types

1. **Pod**
   ```bash
   # Create a basic pod
   kyaml pod nginx --image=nginx
   
   # Pod with custom options
   kyaml pod nginx --image=nginx --port=80 --env="ENV=prod"
   ```

2. **Deployment**
   ```bash
   # Create a basic deployment
   kyaml deployment nginx --image=nginx
   
   # Deployment with replicas
   kyaml deployment nginx --image=nginx --replicas=3
   ```

3. **Service (svc)**
   ```bash
   # Create a ClusterIP service
   kyaml service nginx --port=80 --target-port=8080
   
   # Alternative using svc alias
   kyaml svc nginx --port=80 --target-port=8080
   ```

4. **ConfigMap (cm)**
   ```bash
   # Create from literal values
   kyaml configmap myconfig --from-literal=key1=value1 --from-literal=key2=value2
   
   # Create from file
   kyaml cm myconfig --from-file=config.properties
   ```

5. **Secret**
   ```bash
   # Create generic secret from literal values
   kyaml secret generic mysecret --from-literal=username=admin --from-literal=password=secret
   
   # Create from file
   kyaml secret generic mysecret --from-file=tls.crt --from-file=tls.key
   ```

6. **Job**
   ```bash
   # Create a basic job
   kyaml job backup --image=busybox -- /bin/sh -c 'echo Hello'
   
   # Job with custom options
   kyaml job backup --image=busybox --restart=OnFailure
   ```

7. **CronJob (cj)**
   ```bash
   # Create a basic cronjob
   kyaml cronjob cleanup --image=busybox --schedule='*/1 * * * *'
   
   # CronJob with custom options
   kyaml cj cleanup --image=busybox --schedule='0 2 * * *' --restart=OnFailure
   ```

### Common Options

- `--image`: Required for pod, deployment, job, and cronjob
- `--port` and `--target-port`: Common for services
- `--from-literal`: For configmaps and secrets
- `--from-file`: For configmaps and secrets
- `--schedule`: Required for cronjobs
- `--replicas`: For deployments
- `--restart`: For jobs and cronjobs

### Tips for CKAD Exam

1. Use `kyaml` to quickly generate YAML templates instead of writing them from scratch
2. Remember resource type aliases:
   - `svc` for service
   - `cm` for configmap
   - `cj` for cronjob
3. The generated YAML can be:
   - Redirected to a file: `kyaml pod nginx --image=nginx > pod.yaml`
   - Piped to kubectl apply: `kyaml pod nginx --image=nginx | kubectl apply -f -`
4. Use basic aliases to save time:
   - `k` instead of `kubectl`
   - `kg` to quickly get resources
   - `kd` to describe and troubleshoot
   - `ka` to apply manifests
   - `kx` to execute commands in containers

### Error Handling

The function includes validation for:
- Required arguments (resource type and name)
- Required flags (--image for pod/deployment/job/cronjob)
- Required schedule for cronjobs
- Supported resource types

If any validation fails, the function will display an error message with usage instructions.

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

# Delete resources immediately
kdel pod nginx
kdel deployment nginx-deployment
kdel service nginx-service
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

# Delete with labels
kdel pods -l app=nginx

# Delete with field selector
kdel pods --field-selector status.phase=Failed
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