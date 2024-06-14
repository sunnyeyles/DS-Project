output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet1_id" {
  value = module.subnets.public_subnet1_id
}

output "public_subnet2_id" {
  value = module.subnets.public_subnet2_id
}

output "app_subnet1_id" {
  value = module.subnets.app_subnet1_id
}

output "app_subnet2_id" {
  value = module.subnets.app_subnet2_id
}

output "db_subnet1_id" {
  value = module.subnets.db_subnet1_id
}

output "db_subnet2_id" {
  value = module.subnets.db_subnet2_id
}

output "nat_gw1_id" {
  description = "ID of the first NAT Gateway"
  value       = module.nat_gateway.nat_gw1_id
}

output "nat_gw2_id" {
  description = "ID of the second NAT Gateway"
  value       = module.nat_gateway.nat_gw2_id
}

output "app_sg_id" {
  value = module.security_groups.app_sg_id
}

output "rds_sg_id" {
  value = module.security_groups.rds_sg_id
}

output "efs_sg_id" {
  value = module.security_groups.efs_sg_id
}