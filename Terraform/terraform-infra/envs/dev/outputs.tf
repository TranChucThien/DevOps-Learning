
output "ec2_module_instance_id" {
  value       = module.ec2.instance_id
  description = "The ID of the EC2 instance from the EC2 module."
}

output "ec2_module_public_ip" {
  value       = module.ec2.instance_public_ip
  description = "The public IP address of the EC2 instance from the EC2 module."
}

