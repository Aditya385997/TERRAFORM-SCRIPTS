

resource "aws_lb_target_group" "app_server_target_group" {
  name     = "APP-SERVER"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id
  health_check {
    path = "/"
  }
}

resource "aws_lb_target_group_attachment" "app_server_attachment" {
  target_group_arn = aws_lb_target_group.app_server_target_group.arn
  target_id        = aws_instance.app_servers.id
}

resource "aws_security_group" "load_balancer_sg" {
  name        = "Loadbalancer-security-group"
  description = "Security group for the load balancer"

  vpc_id = aws_vpc.this.id

  // Add inbound rules as needed
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_lb" "load_balancer" {
  name               = "upgrad-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer_sg.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
  enable_deletion_protection = false
  
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_server_target_group.arn
  }
}