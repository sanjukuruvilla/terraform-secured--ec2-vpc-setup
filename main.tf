# main.tf

# Define the VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = {
    Name = "my-vpc"
  }
}

# Define public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.public_subnet_cidr_block
  availability_zone = var.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

# Define private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_cidr_block
  availability_zone = var.availability_zone
  tags = {
    Name = "private-subnet"
  }
}

# Define public NACL
resource "aws_network_acl" "public_nacl" {
  vpc_id = aws_vpc.my_vpc.id
  subnet_ids = [aws_subnet.public_subnet.id]

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }
}

# Define private NACL
resource "aws_network_acl" "private_nacl" {
  vpc_id = aws_vpc.my_vpc.id
  subnet_ids = [aws_subnet.private_subnet.id]

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }
}

# Define public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate public subnet with public route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Define private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "private-route-table"
  }
}

# Associate private subnet with private route table
resource "aws_route_table_association" "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

# Define internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Define security group for public instances
resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.http_cidr_blocks
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define security group for private instances
resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Define public EC2 instance
resource "aws_instance" "public_instance" {
  ami             = var.ami_id
  count           = var.public_instance_count 
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  key_name        = var.key_name
  user_data     = var.user_data
}

# Define private EC2 instance
resource "aws_instance" "private_instance" {
  ami             = var.ami_id
  count           = var.private_instance_count
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  key_name        = var.key_name
  user_data     = var.user_data
}

##Lifecycle management
resource "aws_instance" "Instance_creation"{
  lifecycle {
      create_before_destroy = true
    }
}

##Tagging the instances
##Tagging public instances
resource "aws_instance" "tg_public_instance" {
  count = var.public_instance_count # Define the number of public instances to create

  tags = {
    Name = "Public ${count.index + 1}"  # Set the Name tag to "Public 1" for the first private instance, "Public 2" for the second, and so on
  }
}

##Tagging private instances
resource "aws_instance" "tg_private_instance" {
  count = var.private_instance_count # Define the number of private instances to create

  tags = {
    Name = "Private ${count.index + 1}"  # Set the Name tag to "Private 1" for the first private instance, "Private 2" for the second, and so on
  }
}

##Getting the ip addresses for public and private instances
output "public_ip_addresses" {
  value = aws_instance.public_instance.*.public_ip
}

output "private_ip_addresses" {
  value = aws_instance.private_instance.*.private_ip
}
