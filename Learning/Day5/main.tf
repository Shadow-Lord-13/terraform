# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "terra_pub_ubun" {
  key_name   = "terra-pub-ubun"
  public_key = file("~/.ssh/id_rsa.pub")  # Replace with the path to your public key file
}

resource "aws_vpc" "teraa_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "terra_vpc"
  }
}

resource "aws_subnet" "terra_public_subnet" {
  vpc_id                  = aws_vpc.teraa_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraa-public-subnet"
  }
}

resource "aws_internet_gateway" "terra_igw" {
  vpc_id = aws_vpc.teraa_vpc.id
}

resource "aws_route_table" "terra_route_table_set_1" {
  vpc_id = aws_vpc.teraa_vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terra_igw.id
  }

  tags = {
    Name = "terra-route-table-set-1"
  }
}

resource "aws_route_table_association" "terra_table_table_association_set_1" {
  subnet_id = aws_subnet.terra_public_subnet.id
  route_table_id = aws_route_table.terra_route_table_set_1.id
}

resource "aws_security_group" "terra_sg" {
  vpc_id = aws_vpc.teraa_vpc.id

  ingress {
    description = "Allow SSH into instance"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow only tcp traffic"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all traffi to eixt"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  tags = {
    Name = "terra-sg"
  }
}

resource "aws_instance" "terra-instance-1" {
  ami                     = "ami-0e86e20dae9224db8"
  instance_type           = "t2.micro"
  subnet_id               = aws_subnet.terra_public_subnet.id
  key_name                = aws_key_pair.terra_pub_ubun.key_name
  vpc_security_group_ids = [aws_security_group.terra_sg.id]
  tags = {
    Name = "terra-instance-1"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.ssh/id_rsa") 
    host        = self.public_ip
  }

  # File provisioner to copy a file from local to the remote EC2 instance
  provisioner "file" {
    source      = "app.py"  # Replace with the path to your local file
    destination = "/home/ubuntu/app.py"  # Replace with the path on the remote instance
  }

  provisioner "remote-exec" {
    inline = [ 
      "echo 'Hello from the remote instance'",  # Confirmation message
      "sudo apt update -y",                     # Update package lists
      "sudo apt install -y python3-pip",        # Install Python3 and pip
      "cd /home/ubuntu",                        # Change to home directory of 'ubuntu' user
      "sudo apt install -y python3-flask",      # Install Flask web framework
      "nohup sudo python3 app.py &"
     ]
    
  }
}