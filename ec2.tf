resource "aws_ebs_volume" "data-vol" {
 availability_zone = "eu-west-2a"
 size = var.ebs_size
 tags = {
        Name = "data-volume"
 }

}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.data-vol.id
  instance_id = aws_instance.app.id
}


resource "aws_instance" "app" {
  ami           = var.ec2_amis
  instance_type = var.ec2_instance_type
  iam_instance_profile = aws_iam_instance_profile.some_profile.id
  availability_zone = "eu-west-2a"
  subnet_id = aws_subnet.private.id
  private_ip = "10.20.16.111"

vpc_security_group_ids = [aws_security_group.ec2-sg.id]
key_name = aws_key_pair.pub_key.key_name

user_data = <<-EOF
                #! /bin/bash
                sudo yum install python -y
                sudo yum install git -y
                sudo git clone https://github.com/krishnakakumani/python.git
                sudo su -
                cd python
                python write-numbers.py
  EOF

  
 
  tags = {
    Name = "app"
  }
}



# add key pair

  resource "aws_key_pair" "pub_key" {
  key_name   = "pub_key"
  public_key = file("key/key-linux-1.pub")
  #public_key = file("key/key-linux-1.pub")
}

# Associate elastic IP
resource "aws_eip" "eip" {
    vpc = true
    instance = aws_instance.app.id
    associate_with_private_ip = "10.20.16.111"
    #depends_on = [
    #  aws_internet_gateway.igw
    #]
 }
