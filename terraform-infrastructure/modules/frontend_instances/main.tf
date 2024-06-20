resource "aws_instance" "frontend_instance" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = element(var.public_subnet_ids, count.index % length(var.public_subnet_ids))
  security_groups = [var.security_group_id]
  key_name = "project_keypair_sal"

  tags = {
    Name        = "FrontendInstance${count.index + 1}"
  }

  user_data = <<-EOF
    #!/bin/bash
    # Update package information and install Docker
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker
    
    # Pull the Docker image from Docker Hub
    sudo docker pull sunnyeyles/ds_client:1.0
    
    # Run the Docker container
    sudo docker run -d -p 8080:8080 sunnyeyles/ds_client:1.0
    
    # Run the Docker container
    docker run -d -p 8080:8080 sunnyeyles/ds_client:1.0
    
    # Redirect traffic from port 80 to 8080 (delete after test)
    #iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 8080
    
    #sudo systemctl restart nginx
  EOF

}
    
  

