variable "aws_region" {
  description = "The AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "instance_type" {
  description = "The size of the EC2 instance"
  type        = string
  default     = "t3.micro"
}

variable "instance_name" {
  description = "The name tag for the EC2 instance"
  type        = string
  default     = "Pulsenotify_Dev_Server"
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
  default     = "pulsenotify_admin"
}

variable "db_password" {
  description = "Master password for RDS (supply at apply time)"
  type        = string
  sensitive   = true
}
