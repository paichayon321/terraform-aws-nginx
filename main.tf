# Terraform state will be stored in S3
terraform {
  backend "s3" {
    bucket = "terraform-bucket-poc-3436"
    key    = "terraform.tfstate"
    region = "ap-southeast-1"
  }
}

# Use AWS Terraform provider
provider "aws" {
  region = "ap-southeast-1"
}

# Create EC2 instance
resource "aws_instance" "default" {
  ami                    = var.ami
  count                  = var.instance_count
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.default.id]
  source_dest_check      = false
  user_data = "${file("install_nginx.sh")}"
  instance_type          = var.instance_type

  tags = {
    Name = "nginx-terraform"
  }
}

# Create Security Group for EC2
resource "aws_security_group" "default" {
  name = "terraform-default-sg"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
