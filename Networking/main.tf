provider "aws" {
  region = var.region
}
resource "aws_vpc" "vnet-nebo" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "vnet-nebo"
  }
}
resource "aws_subnet" "snet-public" {
  vpc_id = aws_vpc.vnet-nebo.id
  cidr_block = "10.0.0.0/17"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "snet-public"
  }
  depends_on = [ aws_vpc.vnet-nebo ]
}
resource "aws_subnet" "snet-private" {
  vpc_id = aws_vpc.vnet-nebo.id
  cidr_block = "10.0.128.0/17"
  availability_zone = "us-east-1b"
  tags = {
    Name = "snet-private"
  }
  depends_on = [ aws_vpc.vnet-nebo ]
}
# Define the public route table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vnet-nebo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name= "pub-route-table" 
  }
}
resource "aws_route_table" "priv-rt" {
  vpc_id = aws_vpc.vnet-nebo.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name= "priv-route-table" 
  }
}
resource "aws_route_table_association" "snet-public" {
  subnet_id = aws_subnet.snet-public.id
  route_table_id = aws_route_table.public-rt.id
  depends_on = [ aws_subnet.snet-public ]
}
resource "aws_route_table_association" "snet-private" {
  subnet_id = aws_subnet.snet-private.id
  route_table_id =  aws_route_table.public-rt.id
  depends_on = [ aws_subnet.snet-private ]
}
# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vnet-nebo.id
  tags= {
    Name= "igFromTerraform"
  }
}
resource "aws_route" "route-pub" {
  route_table_id = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
}
resource "aws_security_group" "public" {
  name_prefix = "public"
  vpc_id = aws_vpc.vnet-nebo.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Public Security Group"
  }
}
resource "aws_security_group" "private" {
  name_prefix = "private"
  vpc_id = aws_vpc.vnet-nebo.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.public.id]
  }
  tags = {
    Name = "Private Security Group"
  }
  
}
  
