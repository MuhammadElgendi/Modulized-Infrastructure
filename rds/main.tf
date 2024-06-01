provider "aws" {
  region = "us-east-1"
}

resource "aws_db_subnet_group" "rds" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
  tags = {
    Name = var.subnet_group_name
  }
}

resource "aws_db_parameter_group" "rds" {
  name        = var.parameter_group_name
  family      = var.family
  description = "Custom RDS parameter group"
}

resource "aws_db_instance" "rds" {
  identifier              = var.identifier
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  engine                  = "postgres"
  engine_version          = var.engine_version
  db_name                    = var.db_name
  username                = var.username
  password                = var.password
  parameter_group_name    = aws_db_parameter_group.rds.name
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  vpc_security_group_ids  = var.vpc_security_group_ids
  skip_final_snapshot     = var.skip_final_snapshot
  publicly_accessible     = var.publicly_accessible
  tags = {
    Name = var.identifier
  }
}

