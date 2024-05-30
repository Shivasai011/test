provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "ec2-1" {
  ami = ""
  subnet_id = ""
  instance_type = "t3.small"
  tags = {
    Name = "first_ec2"
  }
}