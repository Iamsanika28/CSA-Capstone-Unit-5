variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Short name used to label resources"
  type        = string
  default     = "secure-three-tier"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "db_name" {
  type    = string
  default = "appdb"
}

variable "db_username" {
  description = "Master username for the demo database"
  type        = string
  default     = "appadmin"
}

variable "db_password" {
  description = "Demo database password. Supply via TF_VAR_db_password or a secrets manager."
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "Choose an instance type supported by your account and region"
  type        = string
  default     = "t3.micro"
}

variable "db_instance_class" {
  description = "Choose an RDS class supported by your account and region"
  type        = string
  default     = "db.t3.micro"
}

variable "allowed_http_cidr" {
  description = "CIDR allowed to access the demo HTTP ALB; restrict this for real deployments"
  type        = string
  default     = "0.0.0.0/0"
}
