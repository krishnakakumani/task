resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"

  tags = var.ec2_tags
}

# create igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# create route table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route{
    cidr_block= "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# set main for route table
resource "aws_main_route_table_association" "rt_main" {
  vpc_id = aws_vpc.my_vpc.id
  route_table_id = aws_route_table.rt.id
  
}

