
resource "aws_internet_gateway" "my_igw2" {
  vpc_id = aws_vpc.my_vpc2.id
  tags = {
    Name = "my-igw2"
  }
}
/* Elastic IP for NAT */

/* NAT */

resource "aws_route_table" "my_public_crt2" {
  vpc_id = aws_vpc.my_vpc2.id

  route {
    //associated subnet can reach everywhere
    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.my_igw2.id
  }

  tags = {
    Name = "my-public-crt2"
  }
}

#privat routetable
resource "aws_route_table" "my_private_crt2" {
  vpc_id = aws_vpc.my_vpc2.id

  route {
    //associated subnet can reach everywhere

    cidr_block = "0.0.0.0/0"
    //CRT uses this IGW to reach internet
    gateway_id = aws_internet_gateway.my_igw2.id
  }

  tags = {
    Name = "my-private-crt2"
  }
}

resource "aws_route_table_association" "my_subnet_public2" {
  subnet_id      = aws_subnet.my_subnet_public2.id
  route_table_id = aws_route_table.my_public_crt2.id
}
resource "aws_route_table_association" "my_subnet_private2" {
  subnet_id      = aws_subnet.my_subnet_private2.id
  route_table_id = aws_route_table.my_private_crt2.id
}
resource "aws_security_group" "rdp_allowed2" {
  vpc_id = aws_vpc.my_vpc2.id

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
    Name = "rdp_allowed2"
  }
}