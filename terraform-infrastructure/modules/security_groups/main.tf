resource "aws_security_group" "app_sg" {
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AppInstanceSecurityGroup"
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id

  tags = {
    Name = "RDSSecurityGroup"
  }
}

resource "aws_security_group" "efs_sg" {
  vpc_id = var.vpc_id

  tags = {
    Name = "EFSMountTargetSecurityGroup"
  }
}

resource "aws_security_group_rule" "efs_ingress" {
  type = "ingress"
  from_port = 2049
  to_port = 2049
  protocol = "tcp"
  source_security_group_id = aws_security_group.app_sg.id
  security_group_id = aws_security_group.efs_sg.id
}