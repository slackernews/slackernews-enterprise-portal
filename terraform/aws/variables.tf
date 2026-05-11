variable "name" {
  description = "Name prefix for RDS resources"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID where the RDS instance will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
}

variable "size" {
  description = "Preset sizing tier: small, medium, large, or extra_large"
  type        = string
  default     = "medium"

  validation {
    condition     = contains(["small", "medium", "large", "extra_large"], var.size)
    error_message = "Size must be one of: small, medium, large, extra_large."
  }
}

variable "instance_class" {
  description = "Override the preset instance class. If set, takes precedence over size mapping."
  type        = string
  default     = ""
}

variable "allocated_storage" {
  description = "Override the preset allocated storage (GiB). If set, takes precedence over size mapping."
  type        = number
  default     = 0
}

variable "multi_az" {
  description = "Enable Multi-AZ high availability"
  type        = bool
  default     = true
}

variable "storage_encrypted" {
  description = "Enable encryption at rest"
  type        = bool
  default     = true
}

variable "database_name" {
  description = "Name of the default database"
  type        = string
  default     = "slackernews"
}

variable "username" {
  description = "Master username for the database"
  type        = string
  default     = "slackernews"
}

variable "password" {
  description = "Master password for the database. If empty, a random password will be generated."
  type        = string
  default     = ""
  sensitive   = true
}

variable "publicly_accessible" {
  description = "Whether the database is publicly accessible"
  type        = bool
  default     = false
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to connect to the database"
  type        = list(string)
  default     = []
}

variable "backup_retention_period" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
