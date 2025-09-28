output "node_group_arn" {
  description = "Amazon Resource Name (ARN) of the EKS Node Group"
  value       = module.eks_managed_node_group.node_group_arn
}

output "node_group_id" {
  description = "EKS node group ID"
  value       = module.eks_managed_node_group.node_group_id
}

output "node_group_status" {
  description = "Status of the EKS Node Group"
  value       = module.eks_managed_node_group.node_group_status
}