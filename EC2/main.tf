provider "aws" {
  region = var.region
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