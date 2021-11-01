resource "aws_key_pair" "mykey" {
  key_name   = "dikshant-aws-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41"

}

resource "aws_security_group" "mysecuritygroup" {
  name        = "TLS"
  description = "Allow TLS inbound traffic"
  vpc_id      = "put your vpc id"


  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }


  tags = {
    Name = "allow_tls"
  }

}





resource "aws_instance" "myos"{
ami = "ami-02e136e904f3da870"
instance_type = "t2.micro"
tags = {
Name = "My OS"
}
}

output "dikshant_launched_myos"{
value = aws_instance.myos.availability_zone
}


resource "aws_ebs_volume" "my_storage"{
availability_zone = aws_instance.myos.availability_zone
size = 1
tags = {
Name = "Dikshant Created Storage"
}
}

output "ebs_output"{
value = aws_ebs_volume.my_storage.id
}



resource "aws_volume_attachment" "letsattach"{
device_name = "/dev/sdh"
instance_id  = aws_instance.myos.id
volume_id = aws_ebs_volume.my_storage.id
}















