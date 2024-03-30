# Creating resources block
resource "aws_instance" "server" {
ami = var.ami
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = "week7d2"
  user_data = file("resume.sh")
  tags = {
  Name = "Terraform-server"
  }
}
# Creating vpc
resource "aws_vpc" "first-vpc" {
  cidr_block = var.vpc_cidir
  tags = {
    name = "production"
  }
}
# Creating subnet-public
resource "aws_subnet" "public1" {
  vpc_id     =aws_vpc.first-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public-subnet"
  }
}
# Creating subnet-private
resource "aws_subnet" "private1" {
  vpc_id     =aws_vpc.first-vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "private-subnet"
  }
}

# 1. Creating vpc
/*
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
  name = "Production"
  }
}
# 2. Create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main"
  }
}
# 3. Create Custom Route Table
resource "aws_route_table" "prod-route-table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "prod"
  }
}
# 4. Create a subnet
resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
availability_zone = "us-east-1a"
  tags = {
    Name = "prod_subnet"
  }
}
# 5. Associate subnet with Route Table
resource "aws_route_table_association" "associa" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_internet_gateway.gw.id
}
# 6. Create security Group to allow port 22,80,443
resource "aws_security_group" "sg" {
vpc_id = aws_vpc.main.id
description = "allow_web_traffic"
  egress {
    description = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
   egress {
   description = "http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
   egress {
     description = "any"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}
# 7. Create a Network Interface with an ip in the subnet that was created in step 4
resource "aws_network_interface" "nic" {
  subnet_id       = aws_subnet.subnet-1.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.sg.id]
}
# 8. Assign an Elastic IP to the network interface created in step 7
resource "aws_eip" "one" {
  domain                   = "vpc"
  network_interface         = aws_network_interface.nic.id
  associate_with_private_ip = "10.0.1.50"
  depends_on = [ aws_internet_gateway.gw]
}
# Create amazon server and install/enable apacke2
resource "aws_instance" "webserver" {
  ami = "ami-02d7fd1c2af6eead0"
  instance_type = "t2.micro"
  availability_zone = "us-east-1a"
  key_name = "week7d2"
  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.nic.id
  }
  user_data = file("resume.sh")
  
}
*/
