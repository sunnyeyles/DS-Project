output "alb_id" {
  description = "The ID of the ALB"
  value       = aws_lb.app_alb.id
}

output "alb_sg_id" {
  description = "The ID of the security group used by the ALB"
  value       = var.security_group_id
}

output "alb_arn" {
  description = "The ARN of the ALB"
  value       = aws_lb.app_alb.arn
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.frontend_target_group.arn
}
