module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = var.vpc_cidr
}


module "subnets" {
  source              = "./modules/subnets"
  vpc_id              = module.vpc.vpc_id
  public_subnet1_cidr = var.public_subnet1_cidr
  public_subnet2_cidr = var.public_subnet2_cidr
  app_subnet1_cidr    = var.app_subnet1_cidr
  app_subnet2_cidr    = var.app_subnet2_cidr
  db_subnet1_cidr     = var.db_subnet1_cidr
  db_subnet2_cidr     = var.db_subnet2_cidr
  region              = var.region
}

module "nat_gateway" {
  source                    = "./modules/nat_gateway"
  public_subnet1_id         = module.subnets.public_subnet1_id
  public_subnet1_private_ip = module.subnets.public_subnet1_private_ip
  public_subnet2_id         = module.subnets.public_subnet2_id
  public_subnet2_private_ip = module.subnets.public_subnet2_private_ip
}

module "route_tables" {
  source            = "./modules/route_tables"
  vpc_id            = module.vpc.vpc_id
  igw_id            = module.vpc.igw_id
  public_subnet1_id = module.subnets.public_subnet1_id
  public_subnet2_id = module.subnets.public_subnet2_id
  app_subnet1_id    = module.subnets.app_subnet1_id
  app_subnet2_id    = module.subnets.app_subnet2_id
  db_subnet1_id     = module.subnets.db_subnet1_id
  db_subnet2_id     = module.subnets.db_subnet2_id
  nat_gw1_id        = module.nat_gateway.nat_gw1_id
  nat_gw2_id        = module.nat_gateway.nat_gw2_id
}



module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}