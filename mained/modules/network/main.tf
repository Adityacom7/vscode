resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = {
    Name = "MyVPC"
    Environment = "Production"
  }
}


  resource "aws_subnet" "public" {
    cidr_block = var.public_subnet_1_cidr
    availability_zone = var.az
    vpc_id = aws_vpc.main.id
  

tags = {
      Name = "PublicSubnet1"
      Environment = "Production"
    }
  }


  resource "aws_subnet" "private" {
    cidr_block = var.public_subnet_2_cidr
    availability_zone = var.az
    vpc_id = aws_vpc.main.id
   tags = {
      Name = "PublicSubnet2"
      Environment = "Production"
    }
  }
  


  resource "aws_internet_gateway" "main" {
    vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "MyInternetGateway"
    Environment = "Production"
    }

  }


  resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
  

    
    route {
      cidr_block = "0.0.0/0"
      gateway_id = aws_internet_gateway.main.id
    }
    tags = {
        Name = "PublicRouteTable"
      }
  }


    resource "aws_route_table_association" "public" {
      subnet_id = aws_subnet.public.id
      route_table_id = aws_route_table.public.id
     
    }


    resource "aws_route_table_association" "public_2" {
      subnet_id = aws_subnet.private.id
      route_table_id = aws_route_table.public.id
    
    }


