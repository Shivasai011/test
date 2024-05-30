provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "first" {
  ami = "ami-0e001c9271cf7f3b9"
  subnet_id = "subnet-0100b3508f5cb942d"
  instance_type = "t3.small"
  tags = {
    Name = "first_ec2"
  }
}