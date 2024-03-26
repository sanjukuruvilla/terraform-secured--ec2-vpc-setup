# variables.tf

variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
}

# Define variables for AMI ID, instance type, and key name
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

variable "user_data" {
  description = "User data script to be executed on instance launch"
  type        = string
}

variable "public_instance_count" {
  description = "Mention the desired number of public instances"
  type        = number
}

variable "private_instance_count" {
  description = "Mention the desired number of private instances"
  type        = number
}

# Define variables for VPC configuration
variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "enable_dns_support" {
  description = "Whether DNS support is enabled for the VPC"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Whether DNS hostnames are enabled for the VPC"
  type        = bool
}

# Define variables for subnet configuration
variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet"
  type        = string
}

variable "availability_zone" {
  description = "The availability zone for the subnet"
  type        = string
}

# Define variables for security group configuration
variable "ssh_cidr_blocks" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
}

variable "http_cidr_blocks" {
  description = "CIDR blocks allowed for HTTP access"
  type        = list(string)
}

# Define variables for NACLs
variable "public_nacls" {
  description = "List of public subnet NACLs"
  type        = list(string)
}

variable "private_nacls" {
  description = "List of private subnet NACLs"
  type        = list(string)
}

# Define variables for route tables
variable "public_route_table_id" {
  description = "ID of the route table for public subnet"
  type        = string
}

variable "private_route_table_id" {
  description = "ID of the route table for private subnet"
  type        = string
}
