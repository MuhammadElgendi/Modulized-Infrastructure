variable "s3_bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
  default     = "terraform-state_Vodabuckets3"
}

variable "kms_key_id" {
  description = "The KMS key ID for S3 encryption."
  type        = string
}
