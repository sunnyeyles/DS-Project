resource "aws_lb" "app_alb" {
  name               = "appALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = [var.public_subnet1_id, var.public_subnet2_id]

  tags = {
    Name = "appALB"
  }
}

resource "aws_lb_target_group" "frontend_target_group" {
  name        = "frontendTargetGroup"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    protocol            = "HTTP"
    path                = "/"
    interval            = 60
    timeout             = 50
    healthy_threshold   = 2
    unhealthy_threshold = 10
    matcher             = "200-399"
  }

  tags = {
    Name = "frontendTargetGroup"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_target_group.arn
  }
}
