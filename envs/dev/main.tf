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

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"   # t2.micro is NOT available in eu-north-1

  tags = {
    Name = "terraform-dev-ec2"
  }
}

