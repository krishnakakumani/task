resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.20.16.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "pri-subnet"
  }
}