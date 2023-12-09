###############################################################
# create vpc
###############################################################

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr //"10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "VPC_1"
  }
}

###############################################################
# Subnets
###############################################################

# create public subnet az1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_az1_cidr //"10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-pub-1"
  }
}

# create public subnet az2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_az2_cidr //"10.0.128.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet-pub-2"
  }
}

# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-1"
  }
}

# create private data subnet az1
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_data_subnet_az1_cidr //"10.0.12.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "subnet-private-1"
  }
}

# create private data subnet az2
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_data_subnet_az2_cidr //"10.0.18.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "subnet-private-2"
  }
}

################################################################
# Route Table
################################################################

# create route table and add public route
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "route-pub"
  }
}

resource "aws_route_table_association" "pub-subnet-association" {
  subnet_id      = aws_subnet.public_subnet_az1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "pub-subnet-association-2" {
  subnet_id      = aws_subnet.public_subnet_az2.id
  route_table_id = aws_route_table.public_route_table.id
}

####################################################################
# Security Group
####################################################################

resource "aws_security_group" "alb_security_group" {
  name        = "alb_security_group"
  description = "allow alb_security_group inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    description = "React Project from VPC"
    from_port   = 30080
    to_port     = 30080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 

  ingress {
    description = "MySQL from VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}