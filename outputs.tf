output "rds_instance_id" {
  description = "ID of the rds instance"
  value       = aws_db_instance.postgres_rds.id
}

output "rds_instance_endpoint" {
  description = "Public endpoint of the rds instance"
  value       = aws_db_instance.postgres_rds.endpoint
}

output "rds_instance_port" {
  description = "Public port of the rds instance"
  value       = aws_db_instance.postgres_rds.port
}

output "rds_db_name" {
  description = "Database name"
  value       = var.rds_db_name
}
