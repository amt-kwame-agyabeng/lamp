# Create web security group
resource "aws_security_group" "web_sg" {
    name = "${local.name_prefix}-web-sg"
    description = "Security group for WebServer"
    vpc_id = var.vpc_id

    tags = merge(local.common_tags, {
        Name = local.web_sg_name

    })

     # Allow HTTP traffic from Internet
    ingress {
      from_port   = var.http_port
      to_port     = var.http_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow HTTPS traffic from Internet
    ingress {
      from_port   = var.https_port
      to_port     = var.https_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      
    }

    # Allow SSH traffic from Internet
    ingress {
      from_port   = var.ssh_port
      to_port     = var.ssh_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  
    }

    # default outbound traffic
    egress  {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  
  
}

# Create database securtiy group

resource "aws_security_group" "sql_sg" {
    name = "${local.name_prefix}-sql-sg"
    description = "Security group for my sql server"
    vpc_id = var.vpc_id

    tags = merge(local.common_tags,{
        Name = local.sql_sg_name

    })
    
    # Allow my sql traffic from web server security group
    ingress {
        from_port = var.mysql_port
        to_port = var.mysql_port
        protocol = "tcp"
        security_groups = [aws_security_group.web_sg.id]
    }

    # Allow SSH traffic from web server security group
    ingress {
        from_port = var.ssh_port
        to_port = var.ssh_port
        protocol = "tcp"
        security_groups = [aws_security_group.app_sg.id]
    }

    #default outbound traffic
     egress  {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_security_group" "app_sg" {
    name = "${local.name_prefix}-app-sg"
    description = "Security group for my app server"
    vpc_id = var.vpc_id

    tags = merge(local.common_tags,{
        Name = local.app_sg_name

    })

    
    # Allow SSH traffic from Internet
    ingress {
      from_port   = var.ssh_port
      to_port     = var.ssh_port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  
    }

    # default outbound traffic
    egress  {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  
}