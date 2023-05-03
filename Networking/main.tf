provider "aws" {
  region = var.region
}
resource "aws_vpc" "vnet-nebo" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vnet-nebo"
  }
}
resource "aws_subnet" "snet-public" {
  vpc_id = aws_vpc.vnet-nebo.id
  cidr_block = "10.0.0.0/17"
  availability_zone = "us-east-1a"
  tags = {
    Name = "snet-public"
  }
  depends_on = [ aws_vpc.vnet-nebo ]
}
resource "aws_subnet" "snet-private" {
  vpc_id = aws_vpc.vnet-nebo.id
  cidr_block = "10.0.128.0/17"
  availability_zone = "us-east-1a"
  tags = {
    Name = "snet-private"
  }
  depends_on = [ aws_vpc.vnet-nebo ]
}
resource "aws_route_table_association" "snet-public" {
  subnet_id = aws_subnet.snet-public.id
  route_table_id = aws_vpc.vnet-nebo.default_route_table_id
  depends_on = [ aws_subnet.snet-public ]
}
resource "aws_route_table_association" "snet-private" {
  subnet_id = aws_subnet.snet-private.id
  route_table_id = aws_vpc.vnet-nebo.default_route_table_id
  depends_on = [ aws_subnet.snet-private ]
}
