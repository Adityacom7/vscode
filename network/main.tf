resource network "vpc" "main" {
  name = "my-vpc"
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  
  tags = {
    Name = "MyVPC"
    Environment = "Production"
  }
}


  resource "subnet" "public" {
    name = "public-subnet-1"
    cidr_block = var.public_subnet_1_cidr
    availability_zone = var.az
    vpc_id = network.vpc.main.id
  

tags = {
      Name = "PublicSubnet1"
      Environment = "Production"
    }
  }


  resource "subnet" "private" {
    name = "public-subnet-2"
    cidr_block = var.public_subnet_2_cidr
    availability_zone = var.az
    vpc_id = network.vpc.main.id
   tags = {
      Name = "PublicSubnet2"
      Environment = "Production"
    }
  }
  


  resource "internet_gateway" "main" {
    vpc_id = network.vpc.main.id
  }

  tags = {
    Name = "MyInternetGateway"
    Environment = "Production"
  }


  resource "route_table" "public" {
    vpc_id = network.vpc.main.id
  

    
    route {
      cidr_block = "0.0.0/0"
      gateway_id = internet_gateway.main.id
    }
    tags = {
        Name = "PublicRouteTable"
      }
  }


    resource "route_table_association" "public" {
      subnet_id = subnet.public.subnet-1.id
      route_table_id = route_table.public.id
      tags = {
        Name = "PublicSubnet1RouteTableAssociation"
      }
    }


    resource "route_table_association" "public_2" {
      subnet_id = subnet.public.subnet-2.id
      route_table_id = route_table.public.id
      tags = {
        Name = "PublicSubnet2RouteTableAssociation"
      }
    }


