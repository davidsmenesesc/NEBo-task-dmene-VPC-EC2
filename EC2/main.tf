provider "aws" {
  region = var.region
}
resource "aws_security_group" "public" {
  name_prefix = "public"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  subnet_ids=[var.subnet_id_pub]
  tags = {
    Name = "Public Security Group"
  }
}
resource "aws_security_group" "private" {
  name_prefix = "private"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.public.id]
  }
  subnet_ids=[var.subnet_id_pub]
  tags = {
    Name = "Private Security Group"
  }
}
resource "aws_instance" "public" {
  ami           = "ami-0aa2b7722dc1b5612"
  instance_type = "t2.micro"
  key_name      = "NEBo-key"
  subnet_id     = var.subnet_ids_pub
  vpc_security_group_ids = [aws_security_group.public.id]
  
  tags = {
    Name = "Public Instance"
  }
  depends_on = [ aws_security_group.public ]
}

resource "aws_instance" "private" {
  ami           = "ami-0aa2b7722dc1b5612"
  instance_type = "t2.micro"
  key_name      = "NEBo-key"
  subnet_id     = var.subnet_ids_priv
  vpc_security_group_ids = [aws_security_group.private.id]
  
  tags = {
    Name = "Private Instance"
  }
  depends_on = [ aws_security_group.private ]
}