resource "aws_security_group" "frontend_sg" {
  vpc_id = var.vpc_id
  name   = "FrontendSecurityGroup"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
    Name = "FrontendSecurityGroup"
  }
}

resource "aws_security_group" "app_sg" {
  vpc_id = var.vpc_id
  name   = "AppInstanceSecurityGroup"

  # Allow SSH access from the frontend security group
  ingress {
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  # Allow HTTP traffic from the frontend security group
  ingress {
    from_port                = 80
    to_port                  = 80
    protocol                 = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  # Allow HTTPS traffic from the frontend security group
  ingress {
    from_port                = 443
    to_port                  = 443
    protocol                 = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  # Allow custom TCP traffic on port 8080 from the frontend security group
  ingress {
    from_port                = 8080
    to_port                  = 8080
    protocol                 = "tcp"
    security_groups = [aws_security_group.frontend_sg.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AppInstanceSecurityGroup"
  }
  depends_on = [aws_security_group.frontend_sg]
}

resource "aws_security_group" "efs_sg" {
  vpc_id = var.vpc_id
  name   = "EFSMountTargetSecurityGroup"

  ingress {
    from_port                = 2049
    to_port                  = 2049
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
    Name = "EFSMountTargetSecurityGroup"
  }
  
  depends_on = [aws_security_group.app_sg]

}

resource "aws_security_group" "rds_sg" {
  vpc_id = var.vpc_id
  name   = "RDSSecurityGroup"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Adjust as needed
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

    depends_on = [aws_security_group.app_sg]

}