variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "tct-eks-cluster-prod"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "tct-final-project"

}
variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.32"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-0dd1e20336beb75e5"
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
  default     = ["subnet-0ad1f45dee4200759"]
}

variable "node_groups" {
  description = "EKS node group configuration"
  type = map(object({
    instance_types = list(string)
    capacity_type  = string
    scaling_config = object({
      desired_size = number
      max_size     = number
      min_size     = number
    })
  }))
}


variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
  default     = null
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS node group"
  type        = string
  default     = null

}