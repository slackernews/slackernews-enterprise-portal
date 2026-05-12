variable "name" {
  description = "Name for the Flexible Server and related resources"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
}

variable "virtual_network_id" {
  description = "Virtual network ID for private access (optional)"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "Subnet ID for private endpoint / delegated subnet (optional)"
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

variable "sku_name" {
  description = "Override the preset SKU name. If set, takes precedence over size mapping."
  type        = string
  default     = ""
}

variable "storage_mb" {
  description = "Override the preset storage size (MB). If set, takes precedence over size mapping."
  type        = number
  default     = 0
}

variable "ha_enabled" {
  description = "Enable zone-redundant high availability"
  type        = bool
  default     = true
}

variable "postgresql_version" {
  description = "PostgreSQL major version"
  type        = string
  default     = "16"
}

variable "database_name" {
  description = "Name of the default database"
  type        = string
  default     = "slackernews"
}

variable "username" {
  description = "Administrator username"
  type        = string
  default     = "slackernews"
}

variable "password" {
  description = "Administrator password. If empty, a random password will be generated."
  type        = string
  default     = ""
  sensitive   = true
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = false
}

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backups"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
