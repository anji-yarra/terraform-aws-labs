provider "aws" {
  region = "eu-north-1"
}

# Fetch latest Amazon Linux 2 AMI for eu-north-1
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

#Security group 

resource "aws_security_group" "web_sg"{
  name = "terraform-dev-sg"
  description = "Allow SSH access"

  ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"   # t2.micro is NOT available in eu-north-1

  tags = {
    Name = "terraform-dev-ec2"
  }
}

