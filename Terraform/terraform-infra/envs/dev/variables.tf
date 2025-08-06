variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "tct-final-project"

}

variable "sg_description" {
  description = "Description for the security group"
  type        = string
  default     = "Security group for EC2 instance"

}


variable "ssh_key_name" {
  description = "Name of the SSH key pair for EC2 instance"
  type        = string
  default     = "tct-ssh-key" # Example key pair name, can be overridden

}

variable "ssh_key_path" {
  description = "Path to the SSH key pair for EC2 instance"
  type        = string
  default     = "./tct-ssh-key.pem" # Example path, can be overridden

}

variable "provisioner_commands" {
  description = "Provisioner commands for EC2 instance"
  type        = list(string)

  default = [
    "sudo yum update -y",
    "sudo amazon-linux-extras enable docker",
    "sudo yum install -y docker",
    "sudo systemctl start docker",
    "sudo systemctl enable docker",
    "sudo usermod -aG docker $USER",
    "newgrp docker",
    # "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
    # "sudo chmod +x /usr/local/bin/docker-compose",
    # "docker-compose version",

  ]

}

variable "ssh_user" {
  description = "SSH user for EC2 instance"
  type        = string
  default     = "ec2-user" # Example SSH user, can be overridden for Amazon Linux 2

}

variable "instance_ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0100e595e1cc1ff7f" # Example AMI ID for Amazon Linux 2 in us-east-2, can be overridden

}