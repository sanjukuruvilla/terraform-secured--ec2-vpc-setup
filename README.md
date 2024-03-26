# Terraform Secured EC2 VPC Setup

![Terraform Logo](https://camo.githubusercontent.com/6d6ec94bb2909d75122df9cf17e1940b522a805587c890a2e37a57eba61f7eb1/68747470733a2f2f7777772e6461746f636d732d6173736574732e636f6d2f323838352f313632393934313234322d6c6f676f2d7465727261666f726d2d6d61696e2e737667)

## Table of Contents

  - [Prerequisites](#prerequisites)
  - [Overview](#overview)
  - [Terraform Files](#terraform-files)
  - [Usage](#usage)
  - [Customization](#customization)
  - [Contributing](#contributing)
  - [License](#license)

## Prerequisites

Before you begin, ensure you have the following prerequisites:

- An AWS account with appropriate permissions to create resources. Refer this [repo](https://github.com/sanjukuruvilla/awscli-linux-configuration.git)
- Terraform installed on your local machine. You can download Terraform from the [official website](https://www.terraform.io/downloads.html) and follow the installation instructions.
- A key pair created in AWS for SSH access to the EC2 instances.

- You can clone the scripts from the repository below to install the awscli and Terraform:
  - Make sure to give execution permission using 'chmod +x TF.sh awscli.sh'
    
  ```bash
  git clone https://github.com/sanjukuruvilla/scripts.git
  ```


## Overview

This repository contains Terraform configuration files to provision secure infrastructure  on AWS. The infrastructure includes a Virtual Private Cloud (VPC), public and private subnets, security groups, and EC2 instances.

## Terraform Files

- **provider.tf**: Configures the AWS provider and region.
- **variables.tf**: Defines variables used in the Terraform configuration.
- **main.tf**: Contains the main Terraform configuration for provisioning infrastructure.
- **variables.tfvars**: Contains the variables configuration for provisioning infrastructure.
- **userdata.sh**: Script file for configurating the ec2 instance.


## Usage

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/sanjukuruvilla/terraform-secured--ec2-vpc-setup.git
   ```

2. Navigate to the repository directory:

   ```bash
   cd terraform-secured--ec2-vpc-setup
   ```

3. Modify `variables.tfvars` file with your desired configurations

4. Initialize Terraform:

   ```bash
   terraform init
   ```
   
5. Validate the Terraform configuration:

   ```bash
   terraform validate
   ```

6. Plan the Terraform configuration:
   specify the **'.tfvars'** file using the **'-var-file'** flag also **'-var'** flag for passing the userdata script file:

   ```bash
   terraform plan -var-file=variables.tfvars -var 'user_data="userdata.sh"' #assuming the userdata.sh is in same location where terraform files present
   ```

8. Apply the Terraform configuration:
   When applying the Terraform configuration, specify the **'.tfvars'** file using the **'-var-file'** flag also **'-var'** flag for passing the userdata script file:

   ```bash
   terraform apply -var-file=variables.tfvars -var 'user_data="userdata.sh"' #assuming the userdata.sh is in same location where terraform files present
   ```
This Terraform ad-hoc command instructs Terraform to read variable values from the specified .tfvars file during the apply operation.

Using .tfvars files in this manner allows for easier management of configuration options, especially when working with multiple environments or configurations.

## Customization

You can customize the Terraform configuration in **'variables.tfvars'** according to your specific requirements:

```bash
aws_region              = "us-east-1"      # Replace with your desired aws_region
ami_id                  = "ami-12345678"   # Replace with your desired AMI ID
instance_type           = "t2.micro"       # Replace with your desired instance type
key_name                = "my-keypair"     # Replace with the name of your key pair
user_data               = ""               # Add user data if required
public_instance_count   = 1                # Specify the desired number of public instances
private_instance_count  = 1                # Specify the desired number of private instances
vpc_cidr_block          = "10.0.0.0/16"    # Define the CIDR block for the VPC
enable_dns_support      = true             # Enable DNS support for the VPC
enable_dns_hostnames    = true             # Enable DNS hostnames for the VPC
public_subnet_cidr_block   = "10.0.1.0/24" # Define the CIDR block for the public subnet
private_subnet_cidr_block  = "10.0.2.0/24" # Define the CIDR block for the private subnet
availability_zones         = "us-east-1a"  # Specify the availability zone for the subnet
ssh_cidr_blocks            = ["0.0.0.0/0"] # CIDR blocks allowed for SSH access
http_cidr_blocks           = ["0.0.0.0/0"] # CIDR blocks allowed for HTTP access
```

## Exporting the ips to a file

  - You can use below adhoc command to get all the values in a file called 'Terraform_output.txt'

      ```bash
      terraform output | grep "private_instance\|public_instance" | grep "ip_address" > instances.txt
      ```
## Exporting the output to a file 
   
   - You can use below adhoc command to get all the values in a file called 'Terraform_output.txt'
   
      ```bash
      terraform output > Terraform_output.txt
      ```



## Contributing

Contributions to this project are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on GitHub.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
