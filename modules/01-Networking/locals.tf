# local variable for naming conventions
locals {
  name_prefix = "${var.owner}-${var.environment}"
}


# Create a local variable for common tags
locals {
  common_tags = {
    Owner = var.owner
    Environment = var.environment
    Region = var.region
  }
}


 # Create a local variable for resources name
 locals {
    vpc_name = "${local.name_prefix}-${var.vpc_name}"
    public_subnet_name = "${local.name_prefix}-${var.public_subnet_name}"
    private_subnet_name = "${local.name_prefix}-${var.private_subnet_name}"
    igw_name = "${local.name_prefix}-${var.igw_name}"
    nat_eip_name = "${local.name_prefix}-${var.nat_eip_name}"
    nat_gw_name = "${local.name_prefix}-${var.nat_gw_name}"
    public_rt_name = "${local.name_prefix}-${var.public_rt_name}"
    private_rt_name = "${local.name_prefix}-${var.private_rt_name}"
 }


 locals {
    availability_zones = ["eu-central-1a", "eu-central-1b"]
   
 }