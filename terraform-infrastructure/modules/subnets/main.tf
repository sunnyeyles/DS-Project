resource "aws_subnet" "public_subnet1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet1_cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}a"
  tags = {
    Name = "PublicSubnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet2_cidr
  map_public_ip_on_launch = true
  availability_zone       = "${var.region}b"
  tags = {
    Name = "PublicSubnet2"
  }
}

resource "aws_subnet" "app_subnet1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.app_subnet1_cidr
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}a"
  tags = {
    Name = "AppSubnet1"
  }
}

resource "aws_subnet" "app_subnet2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.app_subnet2_cidr
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}b"
  tags = {
    Name = "AppSubnet2"
  }
}

resource "aws_subnet" "db_subnet1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.db_subnet1_cidr
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}a"
  tags = {
    Name = "DatabaseSubnet1"
  }
}

resource "aws_subnet" "db_subnet2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.db_subnet2_cidr
  map_public_ip_on_launch = false
  availability_zone       = "${var.region}b"
  tags = {
    Name = "DatabaseSubnet2"
  }
}
resource "aws_network_acl" "public_acl" {
  vpc_id = var.vpc_id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 130
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 8080
    to_port    = 8080
  }

  egress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "PublicNetworkACL"
  }
}

resource "aws_network_acl" "private_acl" {
  vpc_id = var.vpc_id

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.0.0.0/16" # Only allow internal VPC traffic
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 110
    action     = "allow"
    cidr_block = "10.0.0.0/16" # Only allow internal VPC traffic
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "10.0.0.0/16" # Only allow internal VPC traffic
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "tcp"
    rule_no    = 140
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  tags = {
    Name = "PrivateNetworkACL"
  }
}

resource "aws_network_acl_rule" "public_ingress" {
  network_acl_id = aws_network_acl.public_acl.id
  egress         = false
  rule_number    = 200
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "public_egress" {
  network_acl_id = aws_network_acl.public_acl.id
  egress         = true
  rule_number    = 200
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "private_ingress" {
  network_acl_id = aws_network_acl.private_acl.id
  egress         = false
  rule_number    = 200
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "10.0.0.0/16"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "private_egress" {
  network_acl_id = aws_network_acl.private_acl.id
  egress         = true
  rule_number    = 200
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_association" "public_acl_assoc" {
  subnet_id      = aws_subnet.public_subnet1.id
  network_acl_id = aws_network_acl.public_acl.id
}

resource "aws_network_acl_association" "public_acl_assoc_2" {
  subnet_id      = aws_subnet.public_subnet2.id
  network_acl_id = aws_network_acl.public_acl.id
}

resource "aws_network_acl_association" "private_acl_app_subnet1" {
  subnet_id      = aws_subnet.app_subnet1.id
  network_acl_id = aws_network_acl.private_acl.id
}

resource "aws_network_acl_association" "private_acl_app_subnet2" {
  subnet_id      = aws_subnet.app_subnet2.id
  network_acl_id = aws_network_acl.private_acl.id
}

resource "aws_network_acl_association" "private_acl_db_subnet1" {
  subnet_id      = aws_subnet.db_subnet1.id
  network_acl_id = aws_network_acl.private_acl.id
}

resource "aws_network_acl_association" "private_acl_db_subnet2" {
  subnet_id      = aws_subnet.db_subnet2.id
  network_acl_id = aws_network_acl.private_acl.id
}