output "frontend_instance_ids" {
  description = "The IDs of the frontend instances"
  value       = aws_instance.frontend_instance[*].id
}