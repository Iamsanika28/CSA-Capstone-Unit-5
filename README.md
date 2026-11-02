# Secure Three-Tier Application on AWS Using Terraform

## Project Overview

This project demonstrates the deployment of a secure three-tier application infrastructure on Amazon Web Services (AWS) using Terraform.

The infrastructure follows a three-tier architecture consisting of a public load balancing layer, a private application layer, and a private database layer. Terraform is used to automate the creation and management of AWS resources.

## Project Objectives

- Create a custom Virtual Private Cloud (VPC).
- Configure public and private subnets.
- Deploy an Application Load Balancer (ALB) in public subnets.
- Deploy an EC2 application server in a private subnet.
- Configure an Amazon RDS database in private database subnets.
- Implement security groups and network access restrictions.
- Enable VPC Flow Logs and AWS CloudTrail for monitoring.
- Automate infrastructure deployment using Terraform.

## Architecture

The project follows this architecture:

**Internet → Internet Gateway → Application Load Balancer → Private EC2 Application Server → Private RDS Database**

The ALB receives incoming web requests and forwards them to the application server. The application server communicates with the RDS database through restricted security group rules.

## Technologies Used

- **Amazon VPC:** Network isolation and subnet management.
- **Amazon EC2:** Application server.
- **Application Load Balancer:** Distributes incoming application traffic.
- **Amazon RDS:** Managed database service.
- **Internet Gateway:** Internet connectivity for public subnets.
- **NAT Gateway:** Outbound internet connectivity for private resources, where configured.
- **AWS Security Groups:** Network traffic filtering.
- **AWS CloudTrail:** API activity monitoring.
- **VPC Flow Logs:** Network traffic monitoring.
- **Terraform:** Infrastructure as Code (IaC).
- **AWS CLI:** AWS resource management.

## Project Structure

```text
secure-three-tier-aws-terraform/
│
├── terraform/
│   ├── versions.tf
│   ├── variables.tf
│   ├── network.tf
│   ├── security_groups.tf
│   ├── alb.tf
│   ├── compute.tf
│   ├── database.tf
│   ├── monitoring.tf
│   └── outputs.tf
│
├── architecture/
│   └── architecture-diagram.png
│
├── screenshots/
│
├── README.md
├── report.pdf
└── .gitignore
```

## Security Features

1. **Network Isolation:** EC2 and RDS are deployed without public IP access.
2. **Private Database:** RDS is configured with `publicly_accessible = false`.
3. **Restricted Database Access:** Database access is allowed only from the application server's security group.
4. **Security Groups:** Separate security groups control traffic between the ALB, application server, and database.
5. **Encrypted Storage:** RDS storage encryption is enabled.
6. **IAM Role:** EC2 uses an IAM role for AWS Systems Manager access.
7. **IMDSv2:** Metadata access requires IMDSv2 tokens.
8. **VPC Flow Logs:** Network traffic is monitored.
9. **CloudTrail:** AWS account activity is recorded.

## Terraform Deployment

### Prerequisites

- AWS account
- AWS CLI installed and configured
- Terraform installed
- Git installed

### Step 1: Configure AWS CLI

```bash
aws configure
```

### Step 2: Navigate to the Terraform directory

```bash
cd terraform
```

### Step 3: Initialize Terraform

```bash
terraform init
```

### Step 4: Validate the configuration

```bash
terraform validate
```

### Step 5: Review the deployment plan

```bash
terraform plan
```

### Step 6: Deploy the infrastructure

```bash
terraform apply
```

Type `yes` when prompted to confirm deployment.

### Step 7: View Terraform outputs

```bash
terraform output
```

## Screenshots

The screenshots folder contains evidence of the AWS infrastructure deployment, including:

- VPC and subnet configuration
- Application Load Balancer
- EC2 instance
- RDS database
- Security group configuration
- VPC Flow Logs
- CloudTrail
- Application access through the ALB

## Cleanup

To avoid unnecessary AWS charges after completing the project, destroy the resources using:

```bash
terraform destroy
```

Type `yes` to confirm.

## Conclusion

This project demonstrates how Terraform can be used to deploy a secure and scalable three-tier application infrastructure on AWS. It applies cloud security concepts such as network segmentation, private database access, security group restrictions, encryption, IAM roles, and monitoring.

The project provides practical experience with Infrastructure as Code (IaC), AWS networking, cloud security, and automated infrastructure deployment.

