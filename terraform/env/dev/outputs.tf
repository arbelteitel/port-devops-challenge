output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = module.eks.cluster_arn
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = module.eks.cluster_certificate_authority_data
  sensitive   = true
}

output "vpc_id" {
  description = "ID of the VPC where the cluster is deployed"
  value       = module.networking.vpc_id
}

output "oidc_provider_arn" {
  description = "The ARN of the OIDC Provider for IRSA"
  value       = module.eks.oidc_provider_arn
}

output "node_group_arn" {
  description = "ARN of the EKS Node Group"
  value       = module.node_groups.node_group_arn
}

# Backend outputs
output "s3_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  value       = module.terraform_backend.s3_bucket_name
}

output "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  value       = module.terraform_backend.dynamodb_table_name
}

output "backend_config" {
  description = "Backend configuration for migrating to remote state"
  value = {
    bucket         = module.terraform_backend.s3_bucket_name
    key            = "env/dev/terraform.tfstate"
    region         = var.aws_region
    dynamodb_table = module.terraform_backend.dynamodb_table_name
    encrypt        = true
  }
}