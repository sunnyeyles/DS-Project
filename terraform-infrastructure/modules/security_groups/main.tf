###############
## NEW Version
###############

resource "aws_security_group" "frontend_sg" {
  vpc_id = var.vpc_id
  name   = "FrontendSecurityGroup"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "FrontendSecurityGroup"
  }
}

# Trying to add one rule to the frontend_sg for the ALB to communicate with the instances (might be unnessary)
resource "aws_security_group_rule" "frontend_ingress_http_self" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.frontend_sg.id
  security_group_id        = aws_security_group.frontend_sg.id
}

resource "aws_security_group" "app_sg" {
  vpc_id = var.vpc_id
  name = "AppInstanceSecurityGroup"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AppInstanceSecurityGroup"
  }
}

resource "aws_security_group" "efs_sg" {
  vpc_id = var.vpc_id
  name   = "EFSMountTargetSecurityGroup"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EFSMountTargetSecurityGroup"
  }
}

resource "aws_security_group_rule" "efs_ingress_nfs" {
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.frontend_sg.id
  security_group_id        = aws_security_group.efs_sg.id
}

resource "aws_security_group_rule" "efs_ingress_http" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_sg.id
  security_group_id        = aws_security_group.efs_sg.id
}

resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id
  name   = "RDSSecurityGroup"

  ingress {
    from_port                = 3306
    to_port                  = 3306
    protocol                 = "tcp"
    security_groups = [aws_security_group.app_sg.id]
      }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDSSecurityGroup"
  }
}