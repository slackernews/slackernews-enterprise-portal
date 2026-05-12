locals {
  size_presets = {
    small = {
      instance_class    = "db.t3.medium"
      allocated_storage = 20
    }
    medium = {
      instance_class    = "db.m6g.large"
      allocated_storage = 50
    }
    large = {
      instance_class    = "db.m6g.xlarge"
      allocated_storage = 100
    }
    extra_large = {
      instance_class    = "db.m6g.2xlarge"
      allocated_storage = 200
    }
  }

  selected_preset = local.size_presets[var.size]

  instance_class    = var.instance_class != "" ? var.instance_class : local.selected_preset.instance_class
  allocated_storage = var.allocated_storage > 0 ? var.allocated_storage : local.selected_preset.allocated_storage
}

resource "random_password" "password" {
  count   = var.password == "" ? 1 : 0
  length  = 32
  special = false
}

locals {
  db_password = var.password != "" ? var.password : random_password.password[0].result
}

resource "aws_security_group" "rds" {
  name_prefix = "${var.name}-rds-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.name}-rds"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids

  tags = merge(var.tags, {
    Name = "${var.name}-subnet-group"
  })
}

resource "aws_db_instance" "this" {
  identifier             = var.name
  engine                 = "postgres"
  engine_version         = "16"
  instance_class         = local.instance_class
  allocated_storage      = local.allocated_storage
  storage_type           = "gp3"
  multi_az               = var.multi_az
  storage_encrypted      = var.storage_encrypted
  db_name                = var.database_name
  username               = var.username
  password               = local.db_password
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = var.publicly_accessible
  backup_retention_period = var.backup_retention_period
  deletion_protection    = var.deletion_protection
  skip_final_snapshot    = false
  final_snapshot_identifier = "${var.name}-final-snapshot"

  tags = merge(var.tags, {
    Name = var.name
  })
}
