# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "demo-terra-instance-1" {
  ami                     = "ami-0e86e20dae9224db8"
  instance_type           = "t2.micro"
  key_name                = "ubun-pri-key"
  tags = {
    Name = "demo-terra-instance-1"
  }
}