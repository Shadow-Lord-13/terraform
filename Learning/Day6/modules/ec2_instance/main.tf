provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "This is ami for the instance"
}
variable "instance_type" {
  description = "This is instance type for the ec2 instance"
}
variable "instance_name" {
  description = "This is instance name for the ec2 instance"
}
resource "aws_instance" "main_instance_template" {
  ami = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}