variable "region" {
  type = string
  default = "eu-west-2"
}

variable "ebs_size" {
  type = number
  default = 1
}


variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ec2_amis" {
  type    = string
  default = "ami-0f5470fce514b0d36"
}

variable "ec2_tags" {
  type    = map(any)
  default = {
    Name = "AppServer"
  }
  
}



