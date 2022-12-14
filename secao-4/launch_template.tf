resource "aws_launch_template" "servidorweb" {
  name = "servidorweb"

  image_id = "ami-0b0dcb5067f052a63"

  instance_type = "t2.micro"

  key_name = "keypair-devcert"

  vpc_security_group_ids = [aws_security_group.only-my-pc.id,
    aws_security_group.only-web-my-pc.id,
    data.aws_security_group.default.id
  ]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "template-servidorweb"
    }
  }

  user_data = filebase64("${path.module}/userdata.sh")
}