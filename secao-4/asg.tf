resource "aws_autoscaling_group" "asg-webserver" {
  name             = "asg-webserver"
  desired_capacity = 2
  max_size         = 4
  min_size         = 2

  vpc_zone_identifier       = [for s in data.aws_subnet.subnet_ids : s.id]
  target_group_arns         = [aws_lb_target_group.tg-webserver.arn]
  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.servidorweb.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "bat" {
  name                      = "TargetTracking-CPU"
  policy_type               = "TargetTrackingScaling"
  autoscaling_group_name    = aws_autoscaling_group.asg-webserver.name
  estimated_instance_warmup = 300

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 30.0
  }
}