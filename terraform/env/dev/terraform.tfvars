aws_region = "us-west-2"

cluster_name    = "port-devops-dev"
cluster_version = "1.28"
environment     = "dev"

vpc_cidr = "10.0.0.0/16"

# Ultra cost-optimized for dev while maintaining smooth operation
node_instance_types = ["t3.small"]  # Smaller instances for cost savings
node_desired_size   = 1             # Start with minimal nodes
node_max_size       = 2             # Allow scaling up if needed
node_min_size       = 1             # Always keep at least 1 node
single_nat_gateway  = true