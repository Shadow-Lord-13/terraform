resource "aws_security_group" "terra-demo-sg" {
  name        = "terra-demo-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  tags = {
    Name = "terra-demo-sg"
  }
}
resource "aws_vpc_security_group_ingress_rule" "allow_tcp_traffic_ipv4" {
  security_group_id = aws_security_group.terra-demo-sg.id
  cidr_ipv4         = var.cidr_block_vpc
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.terra-demo-sg.id
  cidr_ipv4         = var.cidr_block_egress
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_instance" "demo-terra-instance-1" {
  ami                     = var.ami
  instance_type           = var.instance_type
  key_name                = var.key_name
  vpc_security_group_ids  = [aws_security_group.terra-demo-sg.id]
  tags = {
    Name = var.Name
  }
}

output "instance_public-ip" {
  description = "Public Ip of AWS Instance"
  value = aws_instance.demo-terra-instance-1.public_ip
}