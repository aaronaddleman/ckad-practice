#!/bin/bash

# kubectl aliases for CKAD practice and exam
alias k=kubectl
alias kg='kubectl get'
alias kd='kubectl describe'
alias ka='kubectl apply -f'
alias kx='kubectl exec -it'
alias kdel='kubectl delete --now'

# Function to generate YAML using --dry-run=client
kyaml() {
    if [ $# -lt 2 ]; then
        echo "Usage: kyaml <resource-type> <resource-name> [options]"
        echo "Examples:"
        echo "  kyaml pod nginx --image=nginx"
        echo "  kyaml deployment nginx --image=nginx"
        echo "  kyaml service nginx --port=80 --target-port=8080"
        echo "  kyaml configmap myconfig --from-literal=key=value"
        echo "  kyaml secret generic mysecret --from-literal=key=value"
        echo "  kyaml job myjob --image=busybox"
        echo "  kyaml cronjob mycron --image=busybox --schedule='*/1 * * * *'"
        return 1
    fi

    # Extract resource type and name
    resource_type=$1
    resource_name=$2
    shift 2

    # Run kubectl create with --dry-run=client based on resource type
    case "$resource_type" in
        pod)
            # Parse the image flag
            image=""
            for arg in "$@"; do
                if [[ $arg == --image=* ]]; then
                    image="${arg#*=}"
                    break
                fi
            done
            if [ -z "$image" ]; then
                echo "Error: --image flag is required for pods"
                return 1
            fi
            kubectl run $resource_name --image=$image --dry-run=client -o yaml "$@"
            ;;
        deployment)
            # Parse the image flag
            image=""
            for arg in "$@"; do
                if [[ $arg == --image=* ]]; then
                    image="${arg#*=}"
                    break
                fi
            done
            if [ -z "$image" ]; then
                echo "Error: --image flag is required for deployments"
                return 1
            fi
            kubectl create deployment $resource_name --image=$image --dry-run=client -o yaml "$@"
            ;;
        service|svc)
            # Service creation doesn't require --image
            kubectl create service clusterip $resource_name --dry-run=client -o yaml "$@"
            ;;
        configmap|cm)
            # ConfigMap creation doesn't require --image
            kubectl create configmap $resource_name --dry-run=client -o yaml "$@"
            ;;
        secret)
            # Secret creation doesn't require --image
            kubectl create secret generic $resource_name --dry-run=client -o yaml "$@"
            ;;
        job)
            # Parse the image flag
            image=""
            for arg in "$@"; do
                if [[ $arg == --image=* ]]; then
                    image="${arg#*=}"
                    break
                fi
            done
            if [ -z "$image" ]; then
                echo "Error: --image flag is required for jobs"
                return 1
            fi
            kubectl create job $resource_name --image=$image --dry-run=client -o yaml "$@"
            ;;
        cronjob|cj)
            # Parse the image and schedule flags
            image=""
            schedule=""
            for arg in "$@"; do
                if [[ $arg == --image=* ]]; then
                    image="${arg#*=}"
                fi
                if [[ $arg == --schedule=* ]]; then
                    schedule="${arg#*=}"
                fi
            done
            if [ -z "$image" ]; then
                echo "Error: --image flag is required for cronjobs"
                return 1
            fi
            if [ -z "$schedule" ]; then
                echo "Error: --schedule flag is required for cronjobs"
                return 1
            fi
            kubectl create cronjob $resource_name --image=$image --schedule="$schedule" --dry-run=client -o yaml "$@"
            ;;
        *)
            echo "Error: Unsupported resource type: $resource_type"
            echo "Supported types: pod, deployment, service (svc), configmap (cm), secret, job, cronjob (cj)"
            return 1
            ;;
    esac
}

# Print available aliases and functions
echo "Available kubectl aliases:"
echo "k     = kubectl"
echo "kg    = kubectl get"
echo "kd    = kubectl describe"
echo "ka    = kubectl apply -f"
echo "kx    = kubectl exec -it"
echo "kdel  = kubectl delete --now"
echo ""
echo "Available functions:"
echo "kyaml = Generate YAML using --dry-run=client"
echo "Usage: kyaml <resource-type> <resource-name> [options]"
echo "Examples:"
echo "  kyaml pod nginx --image=nginx"
echo "  kyaml deployment nginx --image=nginx"
echo "  kyaml service nginx --port=80 --target-port=8080"
echo "  kyaml configmap myconfig --from-literal=key=value"
echo "  kyaml secret generic mysecret --from-literal=key=value"
echo "  kyaml job myjob --image=busybox"
echo "  kyaml cronjob mycron --image=busybox --schedule='*/1 * * * *'" 