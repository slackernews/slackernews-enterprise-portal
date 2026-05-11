locals {
  size_presets = {
    small = {
      tier     = "db-f1-micro"
      disk_size = 20
    }
    medium = {
      tier     = "db-custom-2-4096"
      disk_size = 50
    }
    large = {
      tier     = "db-custom-4-16384"
      disk_size = 100
    }
    extra_large = {
      tier     = "db-custom-8-32768"
      disk_size = 200
    }
  }

  selected_preset = local.size_presets[var.size]

  tier      = var.tier != "" ? var.tier : local.selected_preset.tier
  disk_size = var.disk_size > 0 ? var.disk_size : local.selected_preset.disk_size
}

resource "random_password" "password" {
  count   = var.password == "" ? 1 : 0
  length  = 32
  special = false
}

locals {
  db_password = var.password != "" ? var.password : random_password.password[0].result
}

resource "google_sql_database_instance" "this" {
  name             = var.name
  project          = var.project_id
  database_version = var.database_version
  region           = var.region

  settings {
    tier              = local.tier
    availability_type = var.availability_type
    disk_size         = local.disk_size
    disk_type         = "PD_SSD"
    ip_configuration {
      ipv4_enabled    = var.public_ip_enabled
      private_network = var.network != "" ? var.network : null
      authorized_networks {
        name  = "allowed"
        value = join(",", var.authorized_networks)
      }
    }
    backup_configuration {
      enabled                        = var.backup_enabled
      start_time                     = "03:00"
      point_in_time_recovery_enabled = true
      backup_retention_settings {
        retained_backups = var.backup_retention_count
      }
    }
    user_labels = var.labels
  }

  deletion_protection = var.deletion_protection
}

resource "google_sql_database" "this" {
  name     = var.database_name
  instance = google_sql_database_instance.this.name
  project  = var.project_id
}

resource "google_sql_user" "this" {
  name     = var.username
  instance = google_sql_database_instance.this.name
  project  = var.project_id
  password = local.db_password
}
