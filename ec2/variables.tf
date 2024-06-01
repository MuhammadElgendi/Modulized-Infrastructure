variable "subnet_id" {
  description = "The subnet ID to launch the instance in."
  type        = string
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with."
  type        = list(string)
}

variable "instance_profile_name" {
  description = "The name of the IAM instance profile."
  type        = string
}
