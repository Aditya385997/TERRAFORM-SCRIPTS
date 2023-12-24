resource "aws_security_group" "bastion_server_sg" {
  name        = "bastion-server-sg"
  description = "Security group for the bastion server"

  vpc_id = aws_vpc.this.id

  // Add inbound rules as needed
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "ssh"
    cidr_blocks = ["0.0.0.0/0"]
  }
}