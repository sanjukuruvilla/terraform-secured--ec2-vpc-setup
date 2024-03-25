# main.tf

# Define the VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" # Define the CIDR block for the VPC
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc" # Add tags to identify the VPC
  }
}

# subnet.tf

# Define public EC2 instance
resource "aws_instance" "public_instance" {
  ami             = var.ami_id # Specify the desired AMI ID
  instance_type   = var.instance_type # Specify the instance type
  subnet_id       = aws_subnet.public_subnet.id # Associate instance with public subnet
  vpc_security_group_ids = [aws_security_group.public_sg.id] # Associate instance with public security group
  key_name        = var.key_name # Specify the key pair name for SSH access
  tags = {
    Name = "public-instance" # Add tags to identify the instance
  }
  depends_on = [aws_vpc.my_vpc, aws_subnet.public_subnet, aws_security_group.public_sg] # Ensure VPC, public subnet, and security group are created first
}

# Define private EC2 instance
resource "aws_instance" "private_instance" {
  ami             = var.ami_id # Specify the desired AMI ID
  instance_type   = var.instance_type # Specify the instance type
  subnet_id       = aws_subnet.private_subnet.id # Associate instance with private subnet
  vpc_security_group_ids = [aws_security_group.private_sg.id] # Associate instance with private security group
  tags = {
    Name = "private-instance" # Add tags to identify the instance
  }
  depends_on = [aws_vpc.my_vpc, aws_subnet.private_subnet, aws_security_group.private_sg] # Ensure VPC, private subnet, and security group are created first
}

# security_groups.tf

# Define security group for public instances
resource "aws_security_group" "public_sg" {
  name        = "public-sg" # Specify the name of the security group
  vpc_id      = aws_vpc.my_vpc.id # Associate security group with the VPC

  # Allow inbound SSH traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow inbound HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [aws_vpc.my_vpc] # Ensure VPC is created first
}

# Define security group for private instances
resource "aws_security_group" "private_sg" {
  name        = "private-sg" # Specify the name of the security group
  vpc_id      = aws_vpc.my_vpc.id # Associate security group with the VPC

  # Allow inbound traffic from public subnet
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_subnet.public_subnet.cidr_block]
  }

  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  depends_on = [aws_vpc.my_vpc, aws_subnet.public_subnet] # Ensure VPC and public subnet are created first
}

# instances.tf

# Define public EC2 instance
resource "aws_instance" "public_instance" {
  ami             = var.ami_id # Specify the desired AMI ID
  instance_type   = var.instance_type # Specify the instance type
  subnet_id       = aws_subnet.public_subnet.id # Associate instance with public subnet
  security_groups = [aws_security_group.public_sg.name] # Associate instance with public security group
  key_name        = var.key_name # Specify the key pair name for SSH access
  tags = {
    Name = "public-instance" # Add tags to identify the instance
  }
  depends_on = [aws_vpc.my_vpc, aws_subnet.public_subnet, aws_security_group.public_sg] # Ensure VPC, public subnet, and security group are created first
}

# Define private EC2 instance
resource "aws_instance" "private_instance" {
  ami             = var.ami_id # Specify the desired AMI ID
  instance_type   = var.instance_type # Specify the instance type
  subnet_id       = aws_subnet.private_subnet.id # Associate instance with private subnet
  security_groups = [aws_security_group.private_sg.name] # Associate instance with private security group
  tags = {
    Name = "private-instance" # Add tags to identify the instance
  }
  depends_on = [aws_vpc.my_vpc, aws_subnet.private_subnet, aws_security_group.private_sg] # Ensure VPC, private subnet, and security group are created first
}
