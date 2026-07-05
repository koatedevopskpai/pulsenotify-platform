output "vpc_id" {
  description = "The ID of the newly created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.pulsenotify_db.endpoint
  sensitive   = true
}

output "app_security_group_id" {
  description = "The ID of the application security group"
  value       = aws_security_group.app_sg.id
}
