terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Configure Kubernetes provider to connect to EKS
provider "kubernetes" {
  host                   = module.eks_cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks_cluster.cluster_certificate_authority_data)
  
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks_cluster.cluster_name]
  }
}

module "eks_cluster" {
  source = "../../modules/eks-cluster"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  environment     = var.environment
  
  vpc_cidr = var.vpc_cidr
  
  node_instance_types = var.node_instance_types
  node_desired_size   = var.node_desired_size
  node_max_size       = var.node_max_size
  node_min_size       = var.node_min_size
  
  single_nat_gateway = var.single_nat_gateway

  tags = {
    Environment = var.environment
    Terraform   = "true"
    Project     = "port-devops-challenge"
  }
}