variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "port-devops-dev"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.28"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "node_instance_types" {
  description = "Instance types for EKS node group"
  type        = list(string)
  default     = ["t3.small"]
}

variable "node_ami_type" {
  description = "AMI type for EKS node group (AL2_x86_64 or AL2_ARM_64)"
  type        = string
  default     = "AL2_x86_64"
}

variable "node_desired_size" {
  description = "Desired number of nodes"
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum number of nodes"
  type        = number
  default     = 3
}

variable "node_min_size" {
  description = "Minimum number of nodes"
  type        = number
  default     = 1
}

variable "single_nat_gateway" {
  description = "Use single NAT gateway for cost optimization"
  type        = bool
  default     = true
}

# Backend configuration variables
variable "state_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "port-devops-terraform-state-668383290491"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
  default     = "terraform-state-locks"
}