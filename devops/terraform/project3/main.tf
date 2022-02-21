resource "aws_instance" "web3" {
  ami           = "ami-0ee498eea5a3c3f90"
  instance_type = var.instance_type
  # VPC
  subnet_id = aws_subnet.my_subnet_public2.id
  # Security Group
  vpc_security_group_ids = ["${aws_security_group.rdp_allowed2.id}"]

  key_name = var.key_name
  tags = {
    name = "machine3"
  }
  
}
resource "aws_instance" "web4" {
  ami           = "ami-0ee498eea5a3c3f90"
  instance_type = var.instance_type
  # VPC
  subnet_id = aws_subnet.my_subnet_private2.id
  # Security Group
  vpc_security_group_ids = ["${aws_security_group.rdp_allowed2.id}"]
  # the Public SSH key
  key_name = var.key_name
  tags = {

    name = "machine4"
  }

}