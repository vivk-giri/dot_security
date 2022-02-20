resource "aws_instance" "web1" {
  ami           = "ami-0ee498eea5a3c3f90"
  instance_type = var.instance_type
  # VPC
  subnet_id = aws_subnet.my_subnet_public1.id
  # Security Group
  vpc_security_group_ids = ["${aws_security_group.rdp_allowed.id}"]

  key_name = var.key_name
  tags ={
    name="Machine1"
  }

}
resource "aws_instance" "web2" {
  ami           = "ami-0ee498eea5a3c3f90"
  instance_type = var.instance_type
  # VPC
  subnet_id = aws_subnet.my_subnet_private1.id
  # Security Group
  vpc_security_group_ids = ["${aws_security_group.rdp_allowed.id}"]
  # the Public SSH key
  key_name = var.key_name
  tags ={
    name="machine2"
  }

}