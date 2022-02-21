
resource "aws_internet_gateway" "my_igw1" {
  vpc_id = aws_vpc.my_vpc1.id
  tags = {
    Name = "my-igw1"
  }
}
/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.my_igw1]
}
/* NAT */
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.my_subnet_public1.*.id, 0)
  depends_on    = [aws_internet_gateway.my_igw1]
  tags = {
    Name        = "nat"
    
  }
}
resource "aws_route_table" "my_public_crt" {
  vpc_id = aws_vpc.my_vpc1.id

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.my_igw1.id
  }

  tags = {
    Name = "my-public-crt"
  }
}

#privat routetable
resource "aws_route_table" "my_private_crt" {
  vpc_id = aws_vpc.my_vpc1.id

  route {
    //associated subnet can reach everywhere

    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "my-private-crt"
  }
}

resource "aws_route_table_association" "my_subnet_public1" {
  subnet_id      = aws_subnet.my_subnet_public1.id
  route_table_id = aws_route_table.my_public_crt.id
}
resource "aws_route_table_association" "my_subnet_private1" {
  subnet_id      = aws_subnet.my_subnet_private1.id
  route_table_id = aws_route_table.my_private_crt.id
}
resource "aws_security_group" "rdp_allowed" {
  vpc_id = aws_vpc.my_vpc1.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 3389
    to_port   = 3389
    protocol  = "tcp"
    // This means, all ip address are allowed to ssh ! 
    // Do not do it in the production. 
    // Put your office or home address in it!
    cidr_blocks = ["0.0.0.0/0"]
  }
  //If you do not add this rule, you can not reach the NGIX  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "rdp_allowed"
  }
}