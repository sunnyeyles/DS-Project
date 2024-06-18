resource "aws_instance" "frontend_instance" {
  count         = var.instance_count
  ami           = "ami-00ac45f3035ff009e" # replace with a valid AMI ID
  instance_type = "t2.micro"
  subnet_id     = element(var.public_subnet_ids, count.index % length(var.public_subnet_ids))
  security_groups = [var.security_group_id]
  key_name = "testKeyPair"

  tags = {
    Name = "FrontendInstance${count.index + 1}"
  }

  user_data = <<-EOF
            #!/bin/bash
            sudo apt-get update
            sudo apt-get install -y nginx
            sudo systemctl start nginx
            sudo systemctl enable nginx
            echo '<!doctype html>
            <html lang="en"><h1>Home page!</h1></br>
            <h3>(Instance Test)</h3>
            </html>' | sudo tee /var/www/html/index.html
            EOF
}