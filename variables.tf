# variables.tf

# Define variables
variable "ami_id" {
  description = "The ID of the AMI to use for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instances to launch"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair to use for SSH access"
  type        = string
}

