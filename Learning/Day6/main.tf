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
  type = map(string)

  default = {
    "dev" = "terra-instance-dev"
    "stage" = "terra-instance-stage"
    # "prod" = "terra-instance-prod"
  }
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami = var.ami
  instance_type = var.instance_type
  instance_name = lookup(var.instance_name, terraform.workspace, "terra-instance")
}