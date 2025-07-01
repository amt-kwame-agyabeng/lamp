# DB TIER
resource "aws_instance" "db" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[1]
  vpc_security_group_ids = [var.sql_sg_id]
  key_name               = var.key_pair_name

  user_data = templatefile("${path.root}/scripts/db_userdata.sh", {
    db_name     = var.db_name
    db_user     = var.db_user
    db_password = var.db_password

  })

  tags = {
    Name = "${local.name_prefix}-db"
  }
}

# APP TIER
resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[0]
  vpc_security_group_ids = [var.app_sg_id]
  key_name               = var.key_pair_name

  user_data = templatefile("${path.root}/scripts/app_userdata.sh", {
    db_ip       = aws_instance.db.private_ip,
    db_name     = var.db_name,
    db_user     = var.db_user,
    db_password = var.db_password
  })

  tags = {
    Name = "${local.name_prefix}-app"
  }

  depends_on = [aws_instance.db]
}

# WEB TIER
resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_ids[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.web_sg_id]
  key_name                    = var.key_pair_name

  user_data = templatefile("${path.root}/scripts/web_userdata.sh", {
    app_ip = aws_instance.app.private_ip
  })

  tags = {
    Name = "${local.name_prefix}-web"
  }

  depends_on = [aws_instance.app]
}
