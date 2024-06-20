#certificate_arn = "arn:aws:acm:eu-west-3:284445534808:certificate/787fd81e-b3e1-4621-be45-4a7650c4aa3e"
#route53_zone_id = "787fd81e-b3e1-4621-be45-4a7650c4aa3e"
#domain_name     = "project.sapesu.com"

frontend_instance_count = 2
frontend_ami = "ami-00ac45f3035ff009e"  # Replace with your frontend AMI ID
frontend_instance_type = "t2.micro"

backend_instance_count = 2
backend_ami = "ami-00ac45f3035ff009e"  # Replace with your backend AMI ID
backend_instance_type = "t2.micro"

database_instance_count = 2
database_ami = "ami-00ac45f3035ff009e"  # Replace with your database AMI ID
database_instance_type = "t2.micro"

