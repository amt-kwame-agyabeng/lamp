module "networking" {
  source              = "./modules/01-Networking"
  owner               = var.owner
  environment         = var.environment
  region              = var.region
  vpc_name            = var.vpc_name
  igw_name            = var.igw_name
  nat_gw_name         = var.nat_gw_name
  nat_eip_name        = var.nat_eip_name
  vpc_cidr            = var.vpc_cidr
  public_rt_name      = var.public_rt_name
  private_rt_name     = var.private_rt_name
  private_subnet_name = var.private_subnet_name
  public_subnet_name  = var.public_subnet_name
}

module "security" {
  source      = "./modules/02-Security"
  owner       = var.owner
  environment = var.environment
  region      = var.region
  vpc_id      = module.networking.vpc_id
  http_port   = var.http_port
  https_port  = var.https_port
  ssh_port    = var.ssh_port
  mysql_port  = var.mysql_port
  web_sg_name = var.web_sg_name
  sql_sg_name = var.sql_sg_name
  app_sg_name = var.app_sg_name

}


module "compute" {
  source             = "./modules/03-Compute"
  owner              = var.owner
  environment        = var.environment
  region             = var.region
  instance_type      = var.instance_type
  ami_id             = var.ami_id
  key_pair_name      = var.key_pair_name
  vpc_id             = module.networking.vpc_id
  web_sg_id          = module.security.web_sg_id
  sql_sg_id          = module.security.sql_sg_id
  app_sg_id          = module.security.app_sg_id
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
  db_name            = var.db_name
  db_user            = var.db_user
  db_password        = var.db_password

}

module "database" {
  source             = "./modules/04-Database"
  owner              = var.owner
  environment        = var.environment
  region             = var.region
  db_name            = var.db_name
  db_password        = var.db_password
  private_subnet_ids = module.networking.private_subnet_ids
  sg_sql_id          = module.security.sql_sg_id
}