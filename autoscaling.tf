resource "aws_launch_template" "web" {
  name_prefix   = "devops-web-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = filebase64("user-data.sh")

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "devops-asg-instance"
    }
  }
}

resource "aws_autoscaling_group" "web" {
  name = "devops-web-asg"

  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  vpc_zone_identifier = data.aws_subnets.default.ids

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  target_group_arns = [
    aws_lb_target_group.web.arn
  ]

  health_check_type         = "ELB"
  health_check_grace_period = 120

  tag {
    key                 = "Name"
    value               = "devops-asg-instance"
    propagate_at_launch = true
  }
}
