# Variables for resorces
variable "ami" {
  description = "ami value for instance (better be free tier as I dont have money to pay otherwise)"
  type = string
}
variable "instance_type" {
  description = "instance type (please select free tier asalready said)"
  type = string
}
variable "key_name" {
  description = "key pair name (lucky for me its free)"
  type = string
}
variable "Name" {
  description = "who will chage me for a tag it is free right????"
  type = string
}
variable "vpc_id" {
  description = "VPC ID"
}
variable "cidr_block_vpc" {
  description = "CIDR block of VPC"
}
variable "cidr_block_egress" {
  description = "CIDR block for Egress"
}