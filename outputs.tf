output "vpc_id" {
  value = module.vpc.vpc_id
}

# output "public_subnet_id" {
#   value = module.vpc.public_subnet_id
# }

# output "private_subnet_id" {
#   value = module.vpc.private_subnet_id
# }

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "rds_instance_id" {
  value = module.rds.db_instance_id
}

output "rds_endpoint" {
  value = module.rds.db_instance_endpoint
}

output "instance_profile_name" {
  value = module.iam.instance_profile_name
}
# output "route53_record" {
#   value = module.route53.route53_record
# }
# output "lambda_function_arn" {
#   value = module.lambda.lambda_function_arn
# }

# output "api_gateway_url" {
#   value = module.api_gateway.api_gateway_url
# }