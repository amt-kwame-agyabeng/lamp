resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = module.networking.public_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = var.key_pair_name

  user_data = templatefile("${path.module}/scripts/web_user_data.sh", {
    app_ip = aws_instance.app.private_ip
  })

  tags = {
    Name = "${local.name_prefix}-web"
  }

  depends_on = [ aws_instance.app ]
}


resource "aws_instance" "app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = module.networking.private_subnet_ids[0]
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  key_name               = var.key_pair_name

  user_data = templatefile("${path.module}/scripts/app_userdata.sh", {
    db_ip       = aws_instance.db.private_ip
    db_name     = var.db_name
    db_user     = var.db_user
    db_password = var.db_password
  })

  tags = {
    Name = "${local.name_prefix}-app"
  }

  depends_on = [ aws_instance.db ]
}



resource "aws_instance" "db" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = module.networking.private_subnet_ids[1]
  vpc_security_group_ids = [module.security.sql_sg_id]
  key_name               = var.key_pair_name

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y mysql-server

    systemctl enable mysqld
    systemctl start mysqld

    mysql -e "CREATE DATABASE ${var.db_name};"
    mysql -e "CREATE USER '${var.db_user}'@'%' IDENTIFIED BY '${var.db_password}';"
    mysql -e "GRANT ALL PRIVILEGES ON ${var.db_name}.* TO '${var.db_user}'@'%';"
    mysql -e "FLUSH PRIVILEGES;"
  EOF

  tags = {
    Name = "${local.name_prefix}-db"
  }
}


