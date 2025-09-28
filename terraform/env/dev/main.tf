terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
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