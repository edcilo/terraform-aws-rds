variable "aws_profile" {
  description = "AWS Profile"
  default     = "default"
}

variable "aws_region" {
  description = "AWS Region"
  default     = "us-east-1"
}

variable "rds_name" {
  description = "RDS Name"
  default     = "postgres-rds"
}

variable "rds_db_name" {
  description = "DB name"
  default     = "postgres"
}

variable "rds_db_username" {
  description = "DB username"
  default     = "postgres"
}

variable "rds_db_password" {
  description = "DB password"
  default     = "postgres"
}

variable "rds_instance_class" {
  description = "RDS Instance class"
  default     = "db.t3.micro"
}

variable "rds_engine" {
  description = "DB engine"
  default     = "postgres"
}

variable "rds_engine_version" {
  description = "DB engine version"
  default     = "13.4"
}

variable "rds_storage_type" {
  description = "DB Storage type"
  default = "gp2"
}

variable "rds_allocated_storage" {
  description = "RDS allocate storage"
  default = 10
}
