resource "aws_vpc" "this" {
  cidr_block       = "10.100.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "upgrad-vpc"
  }
}

resource "aws_subnet" "public-subnet-1" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.100.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-1"
  }
}


resource "aws_subnet" "public-subnet-2" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.100.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet-2"
  }
}


resource "aws_subnet" "private-subnet-1" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.100.3.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private-subnet-2" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.100.4.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "private-subnet-2"
  }
}

resource "aws_internet_gateway" "igtw" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "upgrad-internet-gateway"
  }
}

resource "aws_eip" "eip" {
  
  domain   = "vpc"
}


resource "aws_nat_gateway" "ngtw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = "upgrad-nat-gateway"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igtw.id
  }
  tags = {
    Name = "public-route-table"
  }
}


resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngtw.id
  }
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "public-route-table-subnet-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}
resource "aws_route_table_association" "public-route-table-subnet-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}
resource "aws_route_table_association" "private-route-table-subnet-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}
resource "aws_route_table_association" "private-route-table-subnet-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}
