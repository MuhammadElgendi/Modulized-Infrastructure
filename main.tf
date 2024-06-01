provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./vpc"

  vpc_name             = var.vpc_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_count  = 1
  public_subnet_cidrs  = var.public_subnet_cidr_blocks 
  private_subnet_count = 2
  private_subnet_cidrs = var.private_subnet_cidr_blocks
  availability_zones   = var.availability_zones
}

module "security_groups" {
  source = "./security_groups"

  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source = "./ec2"

  subnet_id             = module.vpc.private_subnet_id
  vpc_security_group_ids = [module.security_groups.web_server_sg_id]
  instance_profile_name = module.iam.instance_profile_name
}

module "rds" {
  source = "./rds"

  identifier            = "my-postgresql-db"
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  engine_version        = "16.2"
  db_name                = var.db_name
  username            = var.db_username
  password            = var.db_password # Consider using a secure method to handle sensitive data
  subnet_group_name     = "my-db-subnet-group"
  subnet_ids            = module.vpc.private_subnet_ids # Replace with your subnet IDs
  parameter_group_name  = "my-db-parameter-group"
  family                = "postgres16"
  parameters            = [
    {
      name  = "max_connections"
      value = "100"
    },
    {
      name  = "shared_buffers"
      value = "256MB"
    }
  ]
  vpc_security_group_ids = [module.security_groups.rds_sg_id] # Replace with your security group IDs
  skip_final_snapshot    = true
  publicly_accessible    = false
}

module "iam" {
  source = "./iam"
  s3_bucket_name = "voda-s3-bucket-task"
  kms_key_id = aws_kms_key.s3.id
}


resource "aws_kms_key" "rds" {
  description = "KMS key for RDS encryption"
}

resource "aws_kms_key" "s3" {
  description = "KMS key for S3 encryption"
}

# module "route53" {
#   source = "./route53"

#   domain_name = var.domain_name
#   # public_ip   = module.ec2.public_ip
#   instance_id = module.ec2.instance_id
#   vpc_id = module.vpc.vpc_id
# }

module "lambda" {
  source             = "./lambda"
  lambda_function_name = "voda-lambda-to-rds"
  rds_endpoint       = module.rds.db_instance_endpoint
  db_username        = var.db_username
  db_password        = var.db_password
  db_name            = var.db_name
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "MyAPI"
  description = "API Gateway for Lambda"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "myresource"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda.lambda_function_arn
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [aws_api_gateway_integration.integration]

  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}
