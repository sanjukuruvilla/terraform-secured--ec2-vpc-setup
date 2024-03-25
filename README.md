---

# Terraform Secured EC2 VPC Setup

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- An AWS account with appropriate permissions to create resources.
- Terraform installed on your local machine. You can download Terraform from the [official website](https://www.terraform.io/downloads.html) and follow the installation instructions.
- A key pair created in AWS for SSH access to the EC2 instances.

- You can clone the scripts from the repository below to install the awscli and Terraform:

[Script Repository]( https://github.com/sanjukuruvilla/scripts.git)
Make sure to give the execution permission using 'chmod +x TF.sh/awscli.sh'

## Overview

This repository contains Terraform configuration files to provision infrastructure for a small project on AWS. The infrastructure includes a Virtual Private Cloud (VPC), public and private subnets, security groups, and EC2 instances.

## Terraform Files

- **provider.tf**: Configures the AWS provider and region.
- **variables.tf**: Defines variables used in the Terraform configuration.
- **main.tf**: Contains the main Terraform configuration for provisioning infrastructure.

## Usage

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/yourusername/terraform-small-project.git
   ```

2. Navigate to the repository directory:

   ```bash
   cd terraform-secured--ec2-vpc-setup
   ```

3. Create a `variables.tfvars` file with your desired configuration:

   ```hcl
   ami_id        = "ami-12345678"   # Replace with your desired AMI ID
   instance_type = "t2.micro"       # Replace with your desired instance type
   key_name      = "my-keypair"     # Replace with the name of your key pair
   ```

4. Initialize Terraform:

   ```bash
   terraform init
   ```
   
5. Validate the Terraform configuration:

   ```bash
   terraform validate
   ```

6. Plan the Terraform configuration:

   ```bash
   terraform plan -var-file=variables.tfvars
   ```

7. Apply the Terraform configuration:

   ```bash
   terraform apply -var-file=variables.tfvars
   ```


## Customization

You can customize the Terraform configuration according to your specific requirements:

- Adjust the CIDR blocks for the VPC and subnets.
- Choose different instance types or AMIs.
- Modify security group rules to meet your security needs.

## Contributing

Contributions to this project are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on GitHub. Before contributing, please review the [contribution guidelines](CONTRIBUTING.md).


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
