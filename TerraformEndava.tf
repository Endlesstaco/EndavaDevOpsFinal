terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

# Creates the VPC
resource "aws_vpc" "Webserver-vpc" {
  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "Webserver"
  }
}

# Creates the subnet
resource "aws_subnet" "subnet-WebServer" {
  vpc_id            = aws_vpc.Webserver-vpc.id 
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-central-1c"

  tags = {
    Name = "WebServer"
  }
}

# Sets a gateway
resource "aws_internet_gateway" "gw" {
  vpc_id        = aws_vpc.Webserver-vpc.id
 }

# Sets a routing table pointing to the gateway
resource "aws_route_table" "webser-route-table" {
  vpc_id        = aws_vpc.Webserver-vpc.id

  route {
     cidr_block = "0.0.0.0/0"
     gateway_id = aws_internet_gateway.gw.id
}

  tags = {
     Name = "WebServer"
  }
}

# Associates the subnet with the route table
resource "aws_route_table_association" "a" {
   subnet_id      = aws_subnet.subnet-WebServer.id
   route_table_id = aws_route_table.webser-route-table.id
}


# Creates a Security Group
resource "aws_security_group" "allow_http" {
   name        = "allow_http"
   description = "Allows HTTP traffic"
   vpc_id      = aws_vpc.Webserver-vpc.id

# Allows https inbound traffic
ingress {
     description = "HTTPS"
     from_port   = 443
     to_port     = 443
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]

}

# Allows http inbound traffic
ingress {
     description = "HTTP"
     from_port   = 80
     to_port     = 80
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]

}

# Allows SSH
ingress {
     description = "SSH"
     from_port   = 22
     to_port     = 22
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
}

# Allows all egress traffic
egress {

     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
}

tags = {
  Name = "allow_SSH_HTTP"
 }
}

# Creates the instance
resource "aws_instance" "WebServer" {
  ami                    = "ami-0767046d1677be5a0"
  instance_type          = "t2.micro"
  availability_zone      = "eu-central-1c"
  key_name               = "EndavaHomework"  

  tags = {
    Name = "WebServer"
  }
}

