variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "The Name of the VPC."
  type        = string
  default     = "VodaFone-VPC"
}

variable "availability_zones" {
  description = "The availability zone to deploy the subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidr_blocks" {
  description = "The CIDR block for the public subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}


variable "private_subnet_cidr_blocks" {
  description = "The CIDR block for the private subnet."
  type        = list(string)
  default     = ["10.0.2.0/24", "10.0.3.0/24"]
}


variable "db_name" {
  description = "The username for the RDS instance."
  type        = string
  default     = "vodadb"
}

variable "db_username" {
  description = "The username for the RDS instance."
  type        = string
  default     = "vodafone"
}

variable "db_password" {
  description = "The password for the RDS instance."
  type        = string
  default     = "password"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
  default     = "terraform-state_Vodabuckets3"
}

# variable "domain_name" {
#   description = "The custom domain name for the web application."
#   type        = string
# }

# variable "zone_id" {
#   description = "The ID of the hosted zone in Route 53."
#   type        = string
# }