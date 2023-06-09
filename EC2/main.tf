provider "aws" {
  region = var.region
}
resource "aws_instance" "public" {
  ami           = "ami-0aa2b7722dc1b5612"
  instance_type = "t2.micro"
  key_name      = "Nebou-key"
  subnet_id     = var.subnet_ids_pub
  associate_public_ip_address = true
  vpc_security_group_ids = [ var.pub_sg ]
  
  tags = {
    Name = "Public Instance"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/.ssh/mykeypair.pem")
    host        = self.public_ip
  }
  depends_on = [ var.pub_sg ]
}

resource "aws_instance" "private" {
  ami           = "ami-0aa2b7722dc1b5612"
  instance_type = "t2.micro"
  key_name      = "Nebou-key"
  subnet_id     = var.subnet_ids_priv
  vpc_security_group_ids = [var.pub_sg]
  
  tags = {
    Name = "Private Instance"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = aws_instance.public.public_ip
    private_key = file("~/.ssh/mykeypair.pem")
    timeout     = "2m"
  }
  depends_on = [ var.priv_sg ]
}