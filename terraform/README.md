# Terraform Infrastructure

Clean, modular Terraform setup for the Port DevOps Challenge EKS cluster.

## Structure

```
terraform/
├── modules/
│   └── eks-cluster/          # Reusable EKS cluster module
└── environments/
    └── dev/                  # Development environment
```

## Usage

```bash
cd terraform/environments/dev
terraform init
terraform plan
terraform apply
```

## Features

- **VPC**: Multi-AZ setup with public/private subnets
- **EKS**: Managed Kubernetes cluster with version 1.28
- **Node Groups**: Auto-scaling worker nodes (t3.medium)
- **Cost Optimized**: Single NAT gateway, minimal node count
- **Modular Design**: Easy to extend and modify