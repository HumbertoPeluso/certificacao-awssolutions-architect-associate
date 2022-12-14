resource "aws_security_group" "only-my-pc" {
  name        = "only-my-pc"
  description = "Allow ssh from my pc"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from my pc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["189.71.121.81/32"]
  }

  tags = {
    Name = "secao4-sg"
  }
}

resource "aws_security_group" "only-web-my-pc" {
  name        = "only-web-my-pc"
  description = "Allow http from my pc"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from my pc"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["189.71.121.81/32"]
  }

  tags = {
    Name = "secao4-sg"
  }
}

resource "aws_security_group" "sg-for-lb" {
  name        = "security-grouup-for-lb"
  description = "Security group for Loadbalancer"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTP for LB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS for LB"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "secao4-sg"
  }
}