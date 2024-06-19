resource "aws_instance" "backend" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = element(var.private_app_subnet_ids, count.index % length(var.private_app_subnet_ids))
  security_groups = [var.security_group_id]
  #key_name = "datascientest_keypair"


  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo usermod -aG docker ubuntu
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    minikube start --driver=none
  EOF

  tags = {
    Name = "BackendInstance${count.index + 1}"
  }
}