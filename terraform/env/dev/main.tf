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
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

locals {
  common_tags = {
    Environment = var.environment
    Terraform   = "true"
    Project     = "port-devops-challenge"
  }
}

module "networking" {
  source = "../../modules/networking"

  cluster_name       = var.cluster_name
  vpc_cidr          = var.vpc_cidr
  single_nat_gateway = var.single_nat_gateway

  tags = local.common_tags
}

module "eks" {
  source = "../../modules/eks"

  cluster_name        = var.cluster_name
  cluster_version     = var.cluster_version
  vpc_id             = module.networking.vpc_id
  private_subnets    = module.networking.private_subnets
  node_instance_types = var.node_instance_types

  tags = local.common_tags
}

module "node_groups" {
  source = "../../modules/node-groups"

  node_group_name = "main-node-group"
  cluster_name    = module.eks.cluster_name
  cluster_version = var.cluster_version
  private_subnets = module.networking.private_subnets

  instance_types = var.node_instance_types
  min_size      = var.node_min_size
  max_size      = var.node_max_size
  desired_size  = var.node_desired_size

  labels = {
    Environment = var.environment
    NodeGroup   = "main"
  }

  tags = local.common_tags
}