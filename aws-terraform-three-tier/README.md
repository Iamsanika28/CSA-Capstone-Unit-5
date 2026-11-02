# Secure Three-Tier AWS Application with Terraform

## What this project deploys
- VPC with two public, two private application, and two private database subnets across two Availability Zones.
- Internet Gateway and one NAT Gateway.
- Public Application Load Balancer.
- Private Amazon Linux EC2 web server, registered with the ALB target group.
- Private encrypted Amazon RDS MySQL instance, with public access disabled.
- Security groups restricting traffic: Internet -> ALB:80, ALB -> EC2:80, EC2 security group -> RDS:3306.
- VPC Flow Logs sent to CloudWatch Logs.
- Multi-region CloudTrail with logs in a private S3 bucket with public access blocked.
- EC2 Systems Manager role; no public IP or inbound SSH rule is configured.

## Prerequisites
1. AWS account with permission to create VPC, EC2, ALB, RDS, IAM, CloudWatch, S3, and CloudTrail resources.
2. Terraform installed.
3. AWS CLI installed and configured with a least-privilege IAM identity (`aws configure` or AWS IAM Identity Center).
4. Check service quotas and availability for the chosen AWS region.

## Run on Windows PowerShell
Open PowerShell in this folder:

```powershell
Copy-Item terraform.tfvars.example terraform.tfvars
$env:TF_VAR_db_password = "Replace-With-A-Strong-Unique-Password"
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

Review the plan carefully and type `yes` only if you approve the resources and estimated costs.

When complete, Terraform prints the ALB URL. Open it in a browser. It may take a few minutes for the EC2 user-data script and ALB health check to finish.

## Verify security
- EC2 console: confirm the instance is in a private subnet and has no public IPv4 address.
- RDS console: confirm Public access = No and note its private subnet group.
- Security Groups: ALB allows port 80 from `allowed_http_cidr`; app allows port 80 only from the ALB SG; database allows TCP 3306 only from the app SG.
- VPC > Flow Logs: verify the flow log is active. Check the CloudWatch log group `/aws/vpc/secure-three-tier/flow-logs`.
- CloudTrail: verify the trail is logging and review Event history.
- ALB: verify the target group health is Healthy and the ALB URL displays the demo page.

## Screenshots to submit
1. VPC resource map showing the subnets and gateway.
2. Public and private subnet details with CIDR and Availability Zone.
3. ALB details and its public DNS name.
4. EC2 instance details showing private subnet and no public IPv4.
5. RDS details showing Public access = No and storage encryption enabled.
6. Security group inbound rules for ALB, EC2 and RDS.
7. Route tables: public route to IGW, app route to NAT, DB route with no internet default route.
8. VPC Flow Logs and CloudWatch log group.
9. CloudTrail trail status and recent Event history.
10. Browser displaying the ALB-served demo page and target group health.

## Clean up to avoid charges
After taking screenshots, run:

```powershell
terraform destroy
```

Review the destroy plan and type `yes` only if you intend to delete the resources. This demo sets `skip_final_snapshot = true`, `deletion_protection = false`, and an S3 bucket with `force_destroy = true`; database data and trail logs can be permanently deleted. Download any evidence/logs you need first.

## Important limitations / production hardening
- The example uses HTTP on port 80 for a simple classroom demo. For production, use HTTPS with an ACM certificate and an appropriate domain.
- One NAT Gateway is used to reduce cost; it is a single point of failure. Production designs often use one NAT Gateway per AZ.
- The EC2 instance and RDS are single instances for cost control; production may need an Auto Scaling group, Multi-AZ RDS, backups, and deletion protection.
- The demo password is passed through a Terraform variable and may be stored in Terraform state. Protect state and use a secrets-management approach for real workloads.
- The EC2 user-data installs Apache and serves a static page; the page demonstrates the network path but does not implement database queries.
- The default `allowed_http_cidr` is open to the internet for demonstration. Restrict it to a trusted IP or configure HTTPS when possible.
- Terraform state can contain sensitive infrastructure data. Do not commit `terraform.tfstate`, `.terraform/`, or `terraform.tfvars` to Git.
