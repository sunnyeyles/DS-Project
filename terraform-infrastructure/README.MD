	1.	main.tf:
	-	This file will call the different modules and pass the necessary variables to them.
	
    2.	variables.tf:
	-	This file defines all the variables used in the project, including region, VPC CIDR blocks, subnet CIDR blocks, etc.
	
    3.	outputs.tf:
	-	This file defines the outputs of the project, such as subnet IDs and security group IDs.
	
    4.	providers.tf:
	-	This file defines the providers and their configurations.

	5.	modules/:
	-	This directory contains all the modules, each representing a logical component of the infrastructure.


I try to always swipe my terraform clean so you will need to 'terraform init' if you want to test

	echo $AWS_PROFILE  #or your profile for the school's AWS
	terraform init
	terraform validate
	terraform plan
	terraform apply -auto-aprouve
	terraform destroy -auto-aprouve