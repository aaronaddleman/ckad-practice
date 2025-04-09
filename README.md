# CKAD Practice Environment

This repository contains practice materials and exercises for the Certified Kubernetes Application Developer (CKAD) certification.

## Environment Setup

### Prerequisites
- kubectl installed
- Access to a Kubernetes cluster
- Basic understanding of Kubernetes concepts

### Shell Configuration

You can set up kubectl aliases in two ways:

#### Option 1: Using the provided script
This repository includes a `kubectl-aliases.sh` script that you can source in your shell:

```bash
source ./kubectl-aliases.sh
```

#### Option 2: Manual configuration
Alternatively, you can add the following alias to your shell configuration file (e.g., `~/.zshrc` or `~/.bashrc`):

```bash
alias k=kubectl
```

This allows you to use `k` instead of `kubectl` for all commands, which is especially useful during the CKAD exam where time is limited.

### Available Aliases

The following aliases are available (either through the script or manual configuration):

```bash
alias k=kubectl
alias kg='kubectl get'
alias kd='kubectl describe'
alias ka='kubectl apply -f'
alias kx='kubectl exec -it'
```

## Practice Resources

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [CKAD Curriculum](https://github.com/cncf/curriculum)
- [Kubernetes Cheat Sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

## License

This project is licensed under the MIT License - see the LICENSE file for details. 