output "instance_public-ip" {
  description = "Public Ip associated with AWS Instance"
  value = aws_instance.demo-terra-instance.public_ip
}