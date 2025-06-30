# local variable for naming conventions
locals {
  name_prefix = "${var.owner}-${var.environment}-${var.region}"
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
   web_sg_name = "${local.name_prefix}-web-sg"
   sql_sg_name = "${local.name_prefix}-sql-sg"
   app_sg_name = "${local.name_prefix}-app-sg"
  
 }