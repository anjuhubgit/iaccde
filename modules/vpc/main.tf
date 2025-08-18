resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.env}-vpc"
    Environment = var.env
  }
  
}
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id
tags = {
  Name = "{$var.env}-igw"
}  
}
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  count = length(var.public_subnets_cidr)
  cidr_block = var.public_subnets_cidr[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.env}-public-subnets-${count.index+1}"
    Environment = var.env
  }
}
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  count = length(var.private_subnets_cidr)
  cidr_block = var.private_subnets_cidr[count.index]
  tags = {
    Name = "${var.env}-private-subnet-${count.index+1}"
  }
}
resource "aws_eip" "nat" {
  domain = "vpc"
  count = length(var.public_subnets_cidr)
  
}
resource "aws_nat_gateway" "nat" {
  count         = length(var.public_subnets_cidr)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  # tags = {
  #   Name = "${var.env}-nat-gw-${count.index + 1}"
  # }
}
  
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-public-rt"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  count  = length(var.private_subnets_cidr)
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.env}-private-rt-${count.index + 1}"
  }
}

resource "aws_route" "private_nat_gateway" {
  count                  = length(var.private_subnets_cidr)
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[count.index].id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets_cidr)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
