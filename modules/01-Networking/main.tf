# Create VPC
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true


    tags = merge(local.common_tags, {
        Name = local.vpc_name

    })
  
}

# Create public subnets
resource "aws_subnet" "public_subnet" {
    count = 2 
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index)
    availability_zone = local.availability_zones[count.index]
    map_public_ip_on_launch = true 

    tags = merge(local.common_tags, {
        Name = "${local.public_subnet_name}-${count.index}"
        Type = "Public"
    })
  
}

# Create private subnets
resource "aws_subnet" "private_subnet" {
    count = 2 
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(aws_vpc.vpc.cidr_block, 4, count.index + 2)
    availability_zone = local.availability_zones[count.index]
    map_public_ip_on_launch = false 

    tags = merge(local.common_tags, {
        Name = "${local.private_subnet_name}-${count.index}"
        Type = "Private"
    })
  
}

# Create internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id

    tags = merge(local.common_tags, {
        Name = "${local.igw_name}-igw"
        
    })
}

# Create elastic ip for nat gateway
resource "aws_eip" "nat_eip" {
    count = length(local.availability_zones)
    depends_on = [ aws_internet_gateway.igw ]
     tags = {
        Name = "${local.nat_eip_name}-${local.availability_zones[count.index]}"
  }

}

# Create nat gateway
resource "aws_nat_gateway" "nat_gw" {
    count = length(local.availability_zones)
    allocation_id = aws_eip.nat_eip[count.index].id
    subnet_id = aws_subnet.public_subnet[count.index].id

    tags = merge(local.common_tags, {
        Name = "${local.nat_gw_name}-${local.availability_zones[count.index]}"
    })
}

# Create public route table
resource "aws_route_table" "public_rt" {
    count = length(local.availability_zones)
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = merge(local.common_tags, {
        Name = "${local.public_rt_name}-${local.availability_zones[count.index]}-rt"
        
    })
  
}

# Create private route table
resource "aws_route_table" "private_rt" {
    count = length(local.availability_zones)
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat_gw[count.index].id
    }
    tags = merge(local.common_tags, {
        Name = "${local.private_rt_name}-${local.availability_zones[count.index]}-rt"
        
    })
  
}


# Create public route table association
resource "aws_route_table_association" "public_rt_association" {
    count = length(local.availability_zones)
    subnet_id = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_route_table.public_rt[count.index].id
}

# Create private route table association
resource "aws_route_table_association" "private_rt_association" {
    count = length(local.availability_zones)
    subnet_id = aws_subnet.private_subnet[count.index].id
    route_table_id = aws_route_table.private_rt[count.index].id
}


# Tag VPC Default Security as "Do not use"
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Default SG: Do not use"
  }
}

# Tag Default Route Table as "Do not Use"
resource "aws_ec2_tag" "default_rtb" {
  resource_id = aws_vpc.vpc.default_route_table_id
  key = "Name"
  value = "Default Route Table: Do not use" 
  
}

