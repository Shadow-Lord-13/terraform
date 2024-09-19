resource "aws_instance" "demo-terra-instance" {
  ami                     = var.ami_vlaue
  instance_type           = var.instance_type
  key_name                = var.key_name
  tags = {
    Name = var.tag_name
  }
}
