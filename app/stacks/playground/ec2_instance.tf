resource "aws_launch_template" "this" {
  name = "${title(var.service_name)}LaunchTemplate"

  description = "Vanilla AMZ 2023"

  image_id = "ami-09a78b9d8b4a58c6a" // Amazon Linux 2023

  key_name = aws_key_pair.this.key_name

  instance_type = "t4g.micro"

  network_interfaces {
    associate_public_ip_address = true

    subnet_id = aws_subnet.subnet_a.id
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_profile.arn
  }

  tag_specifications {
    resource_type = "instance"

    tags = var.tags
  }

  tags = merge(
    var.tags,
    {
      Name = "${title(var.service_name)}LaunchTemplate"
    }
  )
}
