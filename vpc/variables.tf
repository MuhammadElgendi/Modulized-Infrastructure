variable "vpc_name" {
  description = "The Name of the VPC."
  type        = string
  default     = "vodafone-vpc"
}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnet_count" {
  description = "The number of public subnets"
  type        = number
  default     = 1
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_count" {
  description = "The number of private subnets"
  type        = number
  default     = 2
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
}



variable "availability_zones" {
  description = "The availability zones for the subnets"
  type        = list(string)
}