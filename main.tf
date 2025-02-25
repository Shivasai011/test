provider "aws" {
  region = "us-east-1"
}

# Create a security group
resource "aws_security_group" "test" {
  name_prefix = "test-security-ci-cd-pipeline"
  description = "allow traffic to cicd pipeline"
  vpc_id = "vpc-0cebb36e91b18d752"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 9000
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws_test_security_group"
  }
}

# Create a key pair
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "test_key" {
  key_name   = "test_key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "test_key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "test_key.pem"
}

# Create EC2 instances
resource "aws_instance" "first" {
  ami                    = "ami-0e001c9271cf7f3b9"
  subnet_id              = "subnet-0100b3508f5cb942d"
  instance_type          = "t3.small"
  vpc_security_group_ids = [aws_security_group.test.id]
  key_name               = aws_key_pair.test_key.key_name
  tags = {
    Name = "Jenkins_master"
  }
}

resource "aws_instance" "second" {
  ami                    = "ami-0e001c9271cf7f3b9"
  subnet_id              = "subnet-0100b3508f5cb942d"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.test.id]
  key_name               = aws_key_pair.test_key.key_name
  tags = {
    Name = "Jenkins_Slave"
  }
}

resource "aws_instance" "third" {
  ami                    = "ami-0e001c9271cf7f3b9"
  subnet_id              = "subnet-0100b3508f5cb942d"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.test.id]
  key_name               = aws_key_pair.test_key.key_name
  tags = {
    Name = "Sonarqube"
  }
}

resource "aws_instance" "fourth" {
  ami                    = "ami-0e001c9271cf7f3b9"
  subnet_id              = "subnet-0100b3508f5cb942d"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.test.id]
  key_name               = aws_key_pair.test_key.key_name
  tags = {
    Name = "Nexus"
  }
}

resource "aws_instance" "fifth" {
  ami                    = "ami-0e001c9271cf7f3b9"
  subnet_id              = "subnet-0100b3508f5cb942d"
  instance_type          = "t2.medium"
  vpc_security_group_ids = [aws_security_group.test.id]
  key_name               = aws_key_pair.test_key.key_name
  tags = {
    Name = "EKS_MASTER"
  }
}
