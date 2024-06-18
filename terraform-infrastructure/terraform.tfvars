certificate_arn = "arn:aws:acm:eu-west-3:767397659707:certificate/43614006-a848-42f0-a8c6-eed3af1ffaf4"
route53_zone_id = "Z0485291S1HVGB28P2OW"
domain_name     = "sapesu.com"

frontend_instance_count = 2
frontend_ami = "ami-0fda19674ff597992"  # Replace with your frontend AMI ID
frontend_instance_type = "t2.micro"

backend_instance_count = 2
backend_ami = "ami-0fda19674ff597992"  # Replace with your backend AMI ID
backend_instance_type = "t2.micro"

database_instance_count = 2
database_ami = "ami-0fda19674ff597992"  # Replace with your database AMI ID
database_instance_type = "t2.micro"
