resource "aws_security_group" "ec2-sg" {
  name        = "ec2-sg"
  description = "Allow traffic for AWS ec2"
  vpc_id      = aws_vpc.my_vpc.id

# inbound
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
# outbound
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg"
  }
}
