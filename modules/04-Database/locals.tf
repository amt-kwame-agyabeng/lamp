locals {
  name_prefix = "${var.owner}-${var.environment}"
  
  common_tags = {
    Owner       = var.owner
    Environment = var.environment
   
  }
}