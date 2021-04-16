resource "aws_lb_target_group" "webserver-lb-target-group" {
  name     = "WebServer-TG"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = aws_vpc.webserver-vpc.id

  health_check {
      enabled             = true
      interval            = 300
      path                = "/"
      port                = "80"
      protocol            = "HTTP"
      timeout             = "10"
      healthy_threshold   = 3
      unhealthy_threshold = 5
      matcher             = "200"
  }

  target_type = "instance"
}

