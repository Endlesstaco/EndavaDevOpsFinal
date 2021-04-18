resource "aws_lb" "webserver_loadbalancer" {
  name               = "WebServer-LoadBalancer"
  internal           = false
  load_balancer_type = "application"

  security_groups    = [aws_security_group.webserver_loadbalancer_sg.id]

  subnets            = [aws_subnet.subnet_webserver.id, aws_subnet.subnet_webserver_asg.id]

  enable_deletion_protection = true
}

resource "aws_security_group" "webserver_loadbalancer_sg" {
   name        = "WebServer-LoadBalancer-sg"
   description = "Allows HTTP traffic to the LoadBalancer"
   vpc_id      = aws_vpc.webserver_vpc.id


   # Allows https inbound traffic
   ingress {
       description = "HTTP"
       from_port   = 80
       to_port     = 80
       protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
   }

   egress {
     from_port       = 80
     to_port         = 80
     protocol        = "tcp"
     security_groups = [aws_security_group.webserver_allow_http_sg.id]
   }
}

resource "aws_lb_listener" "webserver_loadbalancer_listener" {
  load_balancer_arn = aws_lb.webserver_loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webserver_lb_target_group.arn
  }
}

