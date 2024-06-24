output "frontend_instance_public_ips" {
  description = "The public IP addresses of the frontend instances"
  value       = data.aws_instances.frontend_instances.public_ips
}

output "frontend_asg_id" {
  description = "The ID of the frontend autoscaling group"
  value       = aws_autoscaling_group.frontend_asg.id
}


