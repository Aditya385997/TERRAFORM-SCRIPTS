resource "aws_lb_target_group" "nginx" {
  name     = "NGINX-APPLICATION"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id
  
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

resource "aws_lb" "Loadbalancer" {
  name               = "LoadBalancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.load_balancer_sg.id]
  subnets = [aws_subnet.public-subnet-1.id,aws_subnet.public-subnet-2]
}



resource "aws_lb_listener" "load_balancer_listener" {
  load_balancer_arn = aws_lb.Loadbalancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "OK"
    }
  }
}


resource "aws_lb_listener_rule" "load_balancer_listener_rule" {
  listener_arn = aws_lb_listener.load_balancer_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }

  condition {
    
  }
}