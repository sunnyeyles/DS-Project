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
  name     = "frontendTargetGroup"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

# Commented out for basic check
#  health_check {
#    path                = "/"
#    interval            = 60
#    timeout             = 50
#    healthy_threshold   = 2
#    unhealthy_threshold = 10
#    matcher             = "200"
#  }
}

#commented out the basic listener that works for basic http without cert
resource "aws_lb_listener" "my_alb_listener" {
 load_balancer_arn = aws_lb.app_alb.arn
 port              = "80"
 protocol          = "HTTP"

 default_action {
   type             = "forward"
   target_group_arn = aws_lb_target_group.frontend_target_group.arn
 }
}

# Create test EC2 instances, not needed anymore. keep as a refference
#resource "aws_instance" "frontend_instance" {
#  count         = var.instance_count
#  ami           = "ami-00ac45f3035ff009e" # replace with a valid AMI ID
#  instance_type = "t2.micro"
#  subnet_id     = element([var.public_subnet1_id, var.public_subnet2_id], count.index % 2)
#  security_groups = [var.security_group_id]
#  key_name = "testKeyPair"
#
#  tags = {
#    Name = "FrontendInstance${count.index + 1}"
#  }
#
#  user_data = <<-EOF
#            #!/bin/bash
#            sudo apt-get update
#            sudo apt-get install -y nginx
#            sudo systemctl start nginx
#            sudo systemctl enable nginx
#            echo '<!doctype html>
#            <html lang="en"><h1>Home page!</h1></br>
#            <h3>(Instance Test)</h3>
#            </html>' | sudo tee /var/www/html/index.html
#            EOF
#}

# Attach EC2 instances to the target group
resource "aws_lb_target_group_attachment" "frontend_attachment" {
  count            = length(var.frontend_instance_ids)
  target_group_arn = aws_lb_target_group.frontend_target_group.arn
  target_id        = var.frontend_instance_ids[count.index]
  port             = 80
}

#commenting out the advenced listener that works for http redirect and https with cert
#resource "aws_lb_listener" "http" {
#  load_balancer_arn = aws_lb.app_alb.arn
#  port              = "80"
#  protocol          = "HTTP"
#
#  default_action {
#    type = "redirect"
#
#    redirect {
#      protocol    = "HTTPS"
#      port        = "443"
#      status_code = "HTTP_301"
#    }
#  }
#}

#resource "aws_lb_listener" "https" {
#  load_balancer_arn = aws_lb.app_alb.arn
#  port              = "443"
#  protocol          = "HTTPS"
#  ssl_policy        = "ELBSecurityPolicy-2016-08"
#
#  certificate_arn   = var.certificate_arn
#
#  }
#}

# Optional: Using aws_lb_listener_certificate if needed
#resource "aws_lb_listener_certificate" "ourservice_ssl_cert" {
#  listener_arn    = aws_lb_listener.https.arn
#  certificate_arn = var.certificate_arn
#}

#resource "aws_route53_record" "app_alb_dns" {
#  zone_id = var.route53_zone_id
#  name    = var.domain_name
#  type    = "A"

#  alias {
#    name                   = aws_lb.app_alb.dns_name
#    zone_id                = aws_lb.app_alb.zone_id
#    evaluate_target_health = true
#  }
#}

