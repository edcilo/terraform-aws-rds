terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.70"
    }
  }

  required_version = ">= 0.14"
}


provider "aws" {
  profile = var.aws_profile
  region  = var.aws_region
}


data "aws_availability_zones" "available" {}


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.0"

  name                 = "${var.rds_name}-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
}


resource "aws_db_subnet_group" "postgres_sub_gr" {
  name        = "${var.rds_name}-subnet-group"
  description = "terrafom db subnet group"
  subnet_ids  = module.vpc.public_subnets
}


resource "aws_security_group" "sec_grp_rds" {
  name        = "${var.rds_name}-group"
  description = "rds security group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_db_instance" "postgres_rds" {
  identifier        = var.rds_name
  storage_type      = var.rds_storage_type
  allocated_storage = var.rds_allocated_storage
  engine            = var.rds_engine
  engine_version    = var.rds_engine_version
  instance_class    = var.rds_instance_class
  name              = var.rds_db_name
  username          = var.rds_db_username
  password          = var.rds_db_password

  publicly_accessible = true
  skip_final_snapshot = true
  multi_az            = false

  vpc_security_group_ids = [aws_security_group.sec_grp_rds.id]
  db_subnet_group_name   = aws_db_subnet_group.postgres_sub_gr.id
}
