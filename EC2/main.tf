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
  vpc_security_group_ids = [var.priv_sg]
  
  tags = {
    Name = "Private Instance"
  }
  depends_on = [ var.priv_sg ]
}
resource "null_resource" "ssh_tunnel" {
  depends_on = [aws_instance.private]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = aws_instance.public.public_ip
    private_key = file("~/.ssh/mykeypair.pem")
    timeout     = "2m"
  }
  provisioner "local-exec" {
    command = "ssh -o StrictHostKeyChecking=no -i ${var.private_key_path} -N -L 2222:${aws_instance.private.private_ip}:22 ec2-user@${aws_instance.bastion.public_ip}"
  }
}