resource "aws_vpc" "my_vpc1" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true" #gives you an internal domain name
  enable_dns_hostnames = "true" #gives you an internal host name
  enable_classiclink   = "false"
  instance_tenancy     = "default"
  tags = {
    Name = "my_vpc1"
  }
}
resource "aws_subnet" "my_subnet_public1" {
  vpc_id                  = aws_vpc.my_vpc1.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = "us-east-2a"

  tags = {
    Name = "my-subnet-public-1"
  }
}
resource "aws_subnet" "my_subnet_private1" {
  vpc_id                  = aws_vpc.my_vpc1.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "false" //it makes this a public subnet
  availability_zone       = "us-east-2a"
  tags = {
    Name = "my-subnet-private-1"
  }
}
