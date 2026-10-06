provider "aws" {
    region = "us-east-2"
}

#VPC
resource "aws_vpc" "main" {
    cidr_block = "192.168.0.0/16"

    tags = {
      Name = "main-tf-vpc"
    }
}

#Subnet1
resource "aws_subnet" "publicsubnet1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "192.168.1.0/24"
    availability_zone = "us-east-2a"

    tags = {
        Name = "Public Subnet 1"
    }
}

#Subnet2
resource "aws_subnet" "publicsubnet2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "192.168.2.0/24"
    availability_zone = "us-east-2b"

    tags = {
        Name = "Public Subnet 2"
    }
}

#Internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id


    tags = {
        Name = "Int gateway"
    }
}

#Route table
resource "aws_route_table" "r" {
    vpc_id = aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "Main Route table"
    }
}

#Route table association1
resource "aws_route_table_association" "assoc1" {
  subnet_id = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.r.id
}


#Route table association2
resource "aws_route_table_association" "assoc2" {
  subnet_id = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.r.id
}