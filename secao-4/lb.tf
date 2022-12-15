resource "aws_lb" "web-lb" {
  name               = "webloadbalancer"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "ipv4"
  security_groups    = [aws_security_group.sg-for-lb.id, data.aws_security_group.default.id]
  subnets            = [for s in data.aws_subnet.subnet_ids : s.id]

  tags = {
    Name = "secao4-lb"
  }
}

resource "aws_lb_listener" "web-lb-listener" {
  load_balancer_arn = aws_lb.web-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg-webserver.arn
  }
}

resource "aws_lb_target_group" "tg-webserver" {
  name        = "tg-webserver"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.default.id

  health_check {
    port     = 80
    protocol = "HTTP"
    path     = "/"
  }
}