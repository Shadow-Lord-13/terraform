provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_vlaue = "ami-0e86e20dae9224db8"
  instance_type =  "t2.micro"
  key_name = "ubun-pri-key"
  tag_name = "demo-terra-instance"
}