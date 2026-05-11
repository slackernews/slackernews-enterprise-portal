locals {
  size_presets = {
    small = {
      sku_name   = "B_Standard_B2s"
      storage_mb = 32768
    }
    medium = {
      sku_name   = "GP_Standard_D2s_v3"
      storage_mb = 65536
    }
    large = {
      sku_name   = "GP_Standard_D4s_v3"
      storage_mb = 131072
    }
    extra_large = {
      sku_name   = "GP_Standard_D8s_v3"
      storage_mb = 262144
    }
  }

  selected_preset = local.size_presets[var.size]

  sku_name   = var.sku_name != "" ? var.sku_name : local.selected_preset.sku_name
  storage_mb = var.storage_mb > 0 ? var.storage_mb : local.selected_preset.storage_mb
}

resource "random_password" "password" {
  count   = var.password == "" ? 1 : 0
  length  = 32
  special = false
}

locals {
  db_password = var.password != "" ? var.password : random_password.password[0].result
}

resource "azurerm_postgresql_flexible_server" "this" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.postgresql_version
  sku_name                      = local.sku_name
  storage_mb                    = local.storage_mb
  administrator_login           = var.username
  administrator_password        = local.db_password
  zone                          = "1"
  public_network_access_enabled = var.public_network_access_enabled
  backup_retention_days         = var.backup_retention_days
  geo_redundant_backup_enabled  = var.geo_redundant_backup_enabled

  delegated_subnet_id = var.subnet_id != "" ? var.subnet_id : null
  private_dns_zone_id  = var.subnet_id != "" ? azurerm_private_dns_zone.this[0].id : null

  dynamic "high_availability" {
    for_each = var.ha_enabled ? [1] : []
    content {
      mode = "ZoneRedundant"
    }
  }

  tags = var.tags
}

resource "azurerm_private_dns_zone" "this" {
  count               = var.subnet_id != "" ? 1 : 0
  name                = "${var.name}.postgres.database.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  name      = var.database_name
  server_id = azurerm_postgresql_flexible_server.this.id
  collation = "en_US.utf8"
  charset   = "utf8"
}
