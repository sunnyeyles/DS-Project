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


EDIT 14.06:
Testing the infrastructure and adding some security.

SG and ACL could be problematic later on if we don't remember the applied rules
Here is a  recap of the testing and resolution:

issues: 
1- SG for DB: no rules assigned
:check_mark: Resolution: Added rules to allow inbound traffic on port 3306 (MySQL) from within the VPC and allow all outbound traffic.
2- SG for app: only one inbound allowing incoming TCP on port 80
:check_mark: Resolution: included rules for both HTTP (port 80) and HTTPS (port 443) traffic
3- SG for EFS: no rules
:check_mark: Resolution: Added rules to allow traffic on port 2049 (NFS) from the app security group.


4- PrivateNetworkACL: no subnet association
5- PublicNetworkACL: no subnet association
:check_mark: Resolution: Associated the PrivateNetworkACL and PublicNetworkACL with the appropriate subnets to apply the ACL rules.
