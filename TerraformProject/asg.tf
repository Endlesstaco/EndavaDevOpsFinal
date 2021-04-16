resource "aws_autoscaling_group" "webserver-autoscaling-group" {
  name     = "WebServer-SG"
  max_size = 3
  min_size = 1

  launch_template {
    id      = aws_launch_template.webserver-launch-template.id
    version = "$Latest"
  }

  vpc_zone_identifier       = [aws_subnet.subnet-webserver.id, aws_subnet.subnet-webserver-asg.id]
  target_group_arns         = [aws_lb_target_group.webserver-lb-target-group.arn]
  
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "webserver-launch-template" {
  name        = "WebServer-LT"
  description = "Launch template of the WebServer"

  block_device_mappings {
    # Root block device is always mapped to /dev/sda1
    device_name = "/dev/sda1"

    ebs {
      delete_on_termination = true
      encrypted             = false
      volume_size           = 8
      volume_type           = "gp2"
    }
  }

  image_id      = "ami-0767046d1677be5a0"
  instance_type = "t2.micro"
  key_name      = "EndavaHomework"

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
    security_groups             = [aws_security_group.webserver-allow-http-sg.id]
  }

  user_data = filebase64("~/TerraformProject/user_data.sh")

}
