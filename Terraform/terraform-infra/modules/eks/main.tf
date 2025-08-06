# This file contains the main configuration for the EKS cluster and node groups.
# It uses the AWS provider to create an EKS cluster and node groups based on the provided variables.
# Requires have an existing VPC, subnet and IAM roles for the EKS cluster and node groups.
# The EKS cluster is created with the specified version and role ARN.


resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = var.cluster_role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
    # subnet_ids = module.vpc.public_subnet_ids if you want to use public subnets in module
  }


}



resource "aws_eks_node_group" "main" {
  for_each = var.node_groups

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = each.key
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids
  # subnet_ids    = module.vpc.private_subnet_ids if you want to use private subnets in module

  instance_types = each.value.instance_types
  capacity_type  = each.value.capacity_type

  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
  }

}