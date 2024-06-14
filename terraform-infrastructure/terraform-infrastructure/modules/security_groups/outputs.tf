output "app_sg_id" {
  description = "ID of the app security group"
  value       = aws_security_group.app_sg.id
}

output "rds_sg_id" {
  description = "ID of the RDS security group"
  value       = aws_security_group.rds_sg.id
}

output "efs_sg_id" {
  description = "ID of the EFS security group"
  value       = aws_security_group.efs_sg.id
}