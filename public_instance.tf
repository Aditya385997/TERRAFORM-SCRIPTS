resource "aws_security_group" "bastion_server_sg" {
  name        = "bastion-server-sg"
  description = "Security group for the bastion server"

  vpc_id = aws_vpc.this.id

  // Add inbound rules as needed
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "bastion-server" {
  ami           = "ami-0c7217cdde317cfec" 
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public-subnet-1.id
  security_groups = [aws_security_group.bastion_server_sg.id]
  key_name = "slave"

  tags = {
    Name = "BASTION-SERVER"
  }


}
