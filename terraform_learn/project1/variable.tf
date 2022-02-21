#creating sample code for TF
#--------------------------Variabe------------------
variable "aws_region" {
  description = "The AWS region to create Infra."
  default     = "us-east-2"
}

variable "key_name" {
  description = " SSH keys to connect to ec2 instance"
  default     = "mylinkey"
}

variable "instance_type" {
  description = "instance type for ec2"
  default     = "t2.micro"
}