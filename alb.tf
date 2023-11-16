# ALB Security group
resource "aws_security_group" "alb-sg" {
  name_prefix   = "alb-sg"
  description   = "Security group for ALB"
  vpc_id        = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ALB-SG"
  }
}


# Create ALB
resource "aws_lb" "alb" {
  name               = "apache-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = [aws_subnet.Public_subnet_1.id, aws_subnet.Public_subnet_2.id, aws_subnet.Public_subnet_3.id]

  tags = {
    Name = "apache-alb"
  }
}

# Create Target Group
resource "aws_lb_target_group" "tg" {
  name     = "apache-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  health_check {
    path = "/"
    port = 80
  }
}

# Create ALB listener
resource "aws_alb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type = "forward"
  }
}

