
resource "aws_security_group" "app_server_sg" {
  name        = "app-server-security-group"
  description = "Security group for the app server"

  vpc_id = aws_vpc.this.id

  // Add inbound rules as needed
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress  {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}



resource "aws_instance" "app_servers" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.app_server_sg.id]
  subnet_id =  aws_subnet.private-subnet-1.id
  key_name = "slave"

  tags = {
    Name = "APP-SERVER"
  }
}