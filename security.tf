provider "aws" {
  region = "ap-northeast-3"
}

resource "aws_security_group" "firewall" {
  name   = "terraform-sg"
  vpc_id = "vpc-04d2914c818b15910"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # allow all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "vm" {
  ami                    = "ami-01cad60940d3582ce"
  instance_type          = "t3.micro"
  key_name               = "my.keypair"
  vpc_security_group_ids = ["sg-0648d497bbf24df4e"]
  user_data              = <<-EOF
     #!/bin/bash
     sudo -i
     apt update -y
     apt install apache2 -y 
     systemctl start httpd
     systemctl enable httpd
     echo "<h1> Hello this terraform" /var/www/html/index.html
  EOF
  tags = {
    Name = "server-name"
  }

}
