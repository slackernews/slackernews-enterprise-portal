variable "name" {
  description = "Name for Cloud SQL instance and related resources"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "network" {
  description = "VPC network self-link or name for private IP connectivity"
  type        = string
  default     = ""
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

variable "tier" {
  description = "Override the preset Cloud SQL machine tier. If set, takes precedence over size mapping."
  type        = string
  default     = ""
}

variable "disk_size" {
  description = "Override the preset disk size (GiB). If set, takes precedence over size mapping."
  type        = number
  default     = 0
}

variable "availability_type" {
  description = "Availability type: REGIONAL (HA) or ZONAL"
  type        = string
  default     = "REGIONAL"
}

variable "database_version" {
  description = "PostgreSQL version"
  type        = string
  default     = "POSTGRES_16"
}

variable "database_name" {
  description = "Name of the default database"
  type        = string
  default     = "slackernews"
}

variable "username" {
  description = "Master username"
  type        = string
  default     = "slackernews"
}

variable "password" {
  description = "Master password. If empty, a random password will be generated."
  type        = string
  default     = ""
  sensitive   = true
}

variable "public_ip_enabled" {
  description = "Enable public IP access"
  type        = bool
  default     = false
}

variable "authorized_networks" {
  description = "List of authorized CIDR blocks for public IP access"
  type        = list(string)
  default     = []
}

variable "backup_enabled" {
  description = "Enable automated backups"
  type        = bool
  default     = true
}

variable "backup_retention_count" {
  description = "Number of backups to retain"
  type        = number
  default     = 7
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = true
}

variable "labels" {
  description = "Labels to apply to all resources"
  type        = map(string)
  default     = {}
}
