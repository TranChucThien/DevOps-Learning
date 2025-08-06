variable "aws_region" {
  description = "AWS region to deploy the S3 bucket"
  type        = string
  default     = "us-east-2"

}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "chucthien-backend"

}

variable "environment" {
  description = "Environment for the S3 bucket (e.g., dev, prod)"
  type        = string
  default     = "dev"

}

variable "project_name" {
  description = "Project name for the S3 bucket"
  type        = string
  default     = "chucthien"

}

