provider "aws" {
  region = var.aws_region
}


#Create security group with firewall rules
resource "aws_security_group" "security_http_port" {
  name        = "security_http_port"
  description = "security group for the new instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security_http_port"
  }
}

resource "aws_instance" "myEC2" {
  ami             = "ami-0fb653ca2d3203ac1"
  key_name        = var.key_name
  instance_type   = var.instance_type
  security_groups = ["security_http_port"]
  tags = {
    Name = "myinstance"
  }
}

# Create Elastic IP address
resource "aws_eip" "myEC2" {
  vpc      = true
  instance = aws_instance.myEC2.id
  tags = {
    Name = "myinstance_elstic_ip"
  }
}
