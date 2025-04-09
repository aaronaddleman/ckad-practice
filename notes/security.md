# Kubernetes Security Best Practices

## Pod Security Concerns

### 1. Pod Security Context
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: secure-pod
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
  containers:
  - name: secure-container
    image: nginx
    securityContext:
      allowPrivilegeEscalation: false
      capabilities:
        drop:
        - ALL
      readOnlyRootFilesystem: true
```

### 2. Network Policies
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
```

### 3. Resource Limits
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: limited-pod
spec:
  containers:
  - name: limited-container
    image: nginx
    resources:
      limits:
        cpu: "1"
        memory: "512Mi"
      requests:
        cpu: "500m"
        memory: "256Mi"
```

## Node Security Concerns

### 1. Node Taints and Tolerations
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: tainted-pod
spec:
  tolerations:
  - key: "security"
    operator: "Equal"
    value: "high"
    effect: "NoSchedule"
  containers:
  - name: secure-container
    image: nginx
```

### 2. Node Affinity
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: affinity-pod
spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: security
            operator: In
            values:
            - high
  containers:
  - name: secure-container
    image: nginx
```

## Security Best Practices

### 1. Pod Security
- Always set `runAsNonRoot: true`
- Drop all capabilities and add only required ones
- Use read-only root filesystem when possible
- Set resource limits and requests
- Use security contexts at both pod and container level
- Avoid privileged containers
- Use non-root user IDs

### 2. Network Security
- Implement Network Policies
- Use service mesh for mTLS
- Restrict pod-to-pod communication
- Use internal services when possible
- Implement ingress controllers with TLS

### 3. Node Security
- Use taints and tolerations for security isolation
- Implement node affinity for security requirements
- Keep nodes updated with security patches
- Use node auto-scaling for security
- Implement node security groups

### 4. Secrets Management
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: secure-secret
type: Opaque
data:
  username: YWRtaW4=
  password: c2VjcmV0
```

### 5. RBAC Implementation
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "watch", "list"]
```

## Security Commands

### 1. Check Pod Security
```bash
# Check pod security context
kubectl get pod <pod-name> -o jsonpath='{.spec.securityContext}'

# Check container security context
kubectl get pod <pod-name> -o jsonpath='{.spec.containers[0].securityContext}'
```

### 2. Check Network Policies
```bash
# List network policies
kubectl get networkpolicies

# Describe network policy
kubectl describe networkpolicy <policy-name>
```

### 3. Check Node Security
```bash
# List node taints
kubectl get nodes -o jsonpath='{.items[*].spec.taints}'

# Check node labels
kubectl get nodes --show-labels
```

### 4. Security Context Commands
```bash
# Create pod with security context
kubectl run secure-pod --image=nginx --overrides='
{
  "spec": {
    "securityContext": {
      "runAsNonRoot": true,
      "runAsUser": 1000
    },
    "containers": [{
      "name": "secure-container",
      "securityContext": {
        "allowPrivilegeEscalation": false,
        "capabilities": {
          "drop": ["ALL"]
        }
      }
    }]
  }
}'
```

## Security Tips for CKAD Exam

1. Always consider security context in pod definitions
2. Use Network Policies to restrict traffic
3. Implement proper resource limits
4. Use non-root users in containers
5. Drop unnecessary capabilities
6. Use read-only root filesystem when possible
7. Implement proper RBAC
8. Use secrets for sensitive data
9. Consider node taints and tolerations
10. Use proper service types and expose only necessary ports 