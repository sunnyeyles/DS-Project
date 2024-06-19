output "frontend_instance_ids" {
  description = "The IDs of the frontend instances"
  value       = aws_instance.frontend_instance[*].id
}
output "frontend_instance_public_ips" {
  description = "The public IP addresses of the frontend instances"
  value       = aws_instance.frontend_instance[*].public_ip
}