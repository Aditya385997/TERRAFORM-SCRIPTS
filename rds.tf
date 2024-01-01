resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "admin"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.public-subnet-1
}
resource "aws_db_subnet_group" "public-subnet-1" {
  name       = "public_subnet_group"
  subnet_ids = [aws_subnet.public-subnet-1] # Public subnets
}