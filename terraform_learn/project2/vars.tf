variable "aws_region" {
  default = "us-east-2"
}
variable "key_name" {
  description = " rdp keys to connect to ec2 instance"
  default     = "mywinkey"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     = "t2.micro"
}
