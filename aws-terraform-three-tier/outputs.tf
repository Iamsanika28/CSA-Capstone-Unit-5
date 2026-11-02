output "alb_dns_name" {
  description = "Open this address to test the demo application"
  value       = "http://${aws_lb.app.dns_name}"
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "app_instance_id" {
  value = aws_instance.app.id
}

output "rds_endpoint" {
  description = "Private endpoint; not directly reachable from the public internet"
  value       = aws_db_instance.app.address
}

output "cloudtrail_bucket_name" {
  value = aws_s3_bucket.cloudtrail.bucket
}
