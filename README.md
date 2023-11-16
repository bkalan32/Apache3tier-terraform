# Terraform Tiered Architecture for Web Application

## Overview
This Terraform project sets up a tiered architecture for a web application on AWS. It's designed for high availability and scalability, aligning with AWS best practices.

### Architecture Components
- **Application Load Balancer (ALB):** Distributes incoming traffic across multiple targets in three public subnets.
- **Auto Scaling Group:** Automatically scales the application based on defined criteria.
- **Launch Template:** Used by the Auto Scaling group to launch EC2 instances.
- **Amazon VPC:** Configured with 2 Availability Zones and 6 subnets (3 public, 3 private).
- **NAT Gateway:** Deployed in public subnets, allowing instances in private subnets internet access.
- **Internet Gateway:** Facilitates communication between the VPC and the internet.
- **EC2 Instances:** Host Apache web server and WordPress in private subnets.

### File Structure
- `outputs.tf`: Defines Terraform configuration outputs.
- `provider.tf`: Configures the AWS provider.
- `variables.tf`: Contains variables like launch template parameters, project name, VPC CIDR range.

## Prerequisites
- An AWS account.
- Terraform installed on your machine.

## Usage
1. **Set AWS Credentials:** Ensure your AWS credentials are configured correctly.
2. **Initialize Terraform:** Run `terraform init`.
3. **Plan Deployment:** Execute `terraform plan`.
4. **Apply Configuration:** Run `terraform apply`.

## Architecture Diagram
Include a diagram of your architecture here if available.

## Security and Networking
- **Security Groups:** Control inbound and outbound traffic.
- **VPC:** Isolates resources, manages network traffic.
- **NAT & Internet Gateways:** Secure internet access for private instances.

## Scaling and Load Balancing
- **Auto Scaling Group:** Maintains performance by adjusting EC2 instances.
- **ALB:** Distributes application traffic across multiple targets.

## Customization
Modify `variables.tf` for custom configurations. Follow AWS security best practices.

## Contributions
Contributions are welcome. Submit pull requests or raise issues as needed.
