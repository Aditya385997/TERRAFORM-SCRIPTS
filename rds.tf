resource "aws_db_instance" "my_sql_database" {
  allocated_storage    = 10
  db_name              = "my_practise_database"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "admin"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.public-subnets.name
}
resource "aws_db_subnet_group" "public-subnets" {
  name       = "public_subnet_group"
  subnet_ids = [aws_subnet.public-subnet-1.id,aws_subnet.public-subnet-2.id] 
}