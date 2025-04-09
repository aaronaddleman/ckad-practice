# Kubectl Command Reference

This document contains useful kubectl commands and their descriptions for CKAD exam preparation.

## Resource Management

### `kubectl api-resources`
Lists all available API resources in the cluster.

#### Common Usage:
```bash
# List all API resources
kubectl api-resources

# List API resources with their short names
kubectl api-resources --namespaced=true

# List API resources with their API versions
kubectl api-resources -o wide
```

#### Key Points:
- Shows all available resource types in the cluster
- Displays resource names, short names, API group, namespaced status, and kind
- Useful for discovering available resources and their short names
- Helpful for understanding which resources are namespaced vs cluster-scoped

#### Example Output:
```
NAME                              SHORTNAMES   APIVERSION                        NAMESPACED   KIND
configmaps                        cm           v1                                true         ConfigMap
deployments                       deploy       apps/v1                           true         Deployment
namespaces                        ns           v1                                false        Namespace
pods                              po           v1                                true         Pod
```

#### Tips:
- Use `--namespaced=true` to filter for namespaced resources only
- Use `-o wide` to see additional details like API versions
- Remember short names (e.g., `po` for pods) for faster command execution during the exam

### `kubectl describe`
Displays detailed information about a specific resource or group of resources.

#### Common Usage:
```bash
# Describe a specific PVC
kubectl describe pvc my-claim

# Describe a pod
kubectl describe pod my-pod

# Describe all pods in a namespace
kubectl describe pods

# Describe a resource in a specific namespace
kubectl describe pod my-pod -n my-namespace
```

#### Key Points:
- Provides detailed information about a resource's configuration and current state
- Shows events related to the resource
- Displays resource specifications and status
- Useful for troubleshooting and understanding resource details

#### Example Output (for PVC):
```
Name:          my-claim
Namespace:     default
StorageClass:  standard
Status:        Bound
Volume:        pvc-12345678-90ab-cdef-0123-456789abcdef
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      1Gi
Access Modes:  RWO
VolumeMode:    Filesystem
Mounted By:    my-pod
Events:
  Type    Reason                 Age   From                         Message
  ----    ------                 ----  ----                         -------
  Normal  ProvisioningSucceeded  2m    persistentvolume-controller  Successfully provisioned volume pvc-12345678-90ab-cdef-0123-456789abcdef
```

#### Tips:
- Use the short name `kd` if you've set up the alias
- Can be used with any resource type (pods, services, deployments, etc.)
- Events section is particularly useful for troubleshooting
- Use `-n` flag to specify namespace when needed
- Can describe multiple resources of the same type at once 