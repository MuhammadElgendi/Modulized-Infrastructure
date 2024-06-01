

variable "identifier" {
  description = "The identifier for the RDS instance"
  type        = string
}

variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The allocated storage in GB"
  type        = number
}

variable "engine_version" {
  description = "The PostgreSQL engine version"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "username" {
  description = "The username for the database"
  type        = string
}

variable "password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}

variable "subnet_ids" {
  description = "The IDs of the subnets in the subnet group"
  type        = list(string)
}

variable "parameter_group_name" {
  description = "The name of the DB parameter group"
  type        = string
}

variable "family" {
  description = "The family of the DB parameter group"
  type        = string
}

variable "parameters" {
  description = "The parameters for the DB parameter group"
  type        = list(object({
    name  = string
    value = string
  }))
}

variable "vpc_security_group_ids" {
  description = "The IDs of the VPC security groups to assign to the RDS instance"
  type        = list(string)
}

variable "skip_final_snapshot" {
  description = "Whether to skip taking a final snapshot before deleting the DB instance"
  type        = bool
  default     = true
}

variable "publicly_accessible" {
  description = "Whether the RDS instance is publicly accessible"
  type        = bool
  default     = false
}
