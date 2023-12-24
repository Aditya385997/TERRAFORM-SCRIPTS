
resource "aws_instance" "bastion-server" {
  ami           = "ami-05d47d29a4c2d19e1" 
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-subnet-1.id
  security_group = [aws_security_group.bastion_server_sg.id]
  key_name = "slave"

  tags = {
    Name = "BASTION-SERVER"
  }


}