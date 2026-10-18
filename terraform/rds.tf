resource "aws_security_group" "rds_sg" {
  name        = "pulsenotify-rds-sg"
  description = "Allow PostgreSQL from app tier"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description     = "PostgreSQL from app security group"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "pulsenotify-rds-sg"
  })
}

resource "aws_db_subnet_group" "pulsenotify_db_subnet" {
  name       = "pulsenotify-db-subnet"
  subnet_ids = module.vpc.private_subnets

  tags = merge(local.common_tags, {
    Name = "pulsenotify-db-subnet"
  })
}

resource "aws_secretsmanager_secret" "db_password" {
  name = "pulsenotify-db-password-${var.environment}"
}

resource "aws_secretsmanager_secret_version" "db_password" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = var.db_password
}

resource "aws_db_instance" "pulsenotify_db" {
  identifier        = "pulsenotify-db-${var.environment}"
  engine            = "postgres"
  engine_version    = "15.4"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "pulsenotifydb"
  username = var.db_username
  password = var.db_password

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.pulsenotify_db_subnet.name

  publicly_accessible       = false
  skip_final_snapshot       = false
  final_snapshot_identifier = "pulsenotify-final-${formatdate("YYYYMMDDhhmm", timestamp())}"
  backup_retention_period   = 7
  backup_window             = "03:00-04:00"
  maintenance_window        = "sun:04:00-sun:05:00"
  deletion_protection       = true
  apply_immediately         = true

  tags = merge(local.common_tags, {
    Name = "pulsenotify-db"
  })
}
