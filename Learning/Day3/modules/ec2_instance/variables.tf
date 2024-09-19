# Variables for resorces
variable "ami_vlaue" {
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
variable "tag_name" {
  description = "who will chage me for a tag it is free right????"
  type = string
}