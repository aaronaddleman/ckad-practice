#!/bin/bash

# kubectl aliases for CKAD practice and exam
alias k=kubectl
alias kg='kubectl get'
alias kd='kubectl describe'
alias ka='kubectl apply -f'
alias kx='kubectl exec -it'

# Function to generate YAML using --dry-run=client
kyaml() {
    if [ $# -lt 2 ]; then
        echo "Usage: kyaml <resource-type> <resource-name> [options]"
        echo "Example: kyaml pod nginx --image=nginx"
        return 1
    fi

    # Extract resource type and name
    resource_type=$1
    resource_name=$2
    shift 2

    # Run kubectl create with --dry-run=client
    kubectl create $resource_type $resource_name "$@" --dry-run=client -o yaml
}

# Print available aliases and functions
echo "Available kubectl aliases:"
echo "k  = kubectl"
echo "kg = kubectl get"
echo "kd = kubectl describe"
echo "ka = kubectl apply -f"
echo "kx = kubectl exec -it"
echo ""
echo "Available functions:"
echo "kyaml = Generate YAML using --dry-run=client"
echo "Usage: kyaml <resource-type> <resource-name> [options]"
echo "Example: kyaml pod nginx --image=nginx" 