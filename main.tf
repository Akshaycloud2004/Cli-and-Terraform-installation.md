provider "aws" {
  region = "ap-south-1"   # Mumbai region
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0f5ee92e2d63afc18"  # Amazon Linux 2 (Mumbai)
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-server"
  }
}
