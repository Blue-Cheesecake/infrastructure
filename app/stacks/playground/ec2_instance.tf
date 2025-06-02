resource "aws_launch_template" "this" {
  name = "${title(var.service_name)}LaunchTemplate"

  description = "ECS Container Host"

  // Amazon Linux 2023 ECS Optimized (ARM64)
  image_id = "ami-0061f8803c66054d2"

  key_name = aws_key_pair.this.key_name

  instance_type = "t4g.micro"

  network_interfaces {
    associate_public_ip_address = true

    subnet_id = aws_subnet.subnet_a.id

    security_groups = [aws_security_group.this.id]
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_profile.arn
  }

  tag_specifications {
    resource_type = "instance"

    tags = var.tags
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo "ECS_CLUSTER=${aws_ecs_cluster.this.name}" >> /etc/ecs/ecs.config
              EOF
  )

  tags = merge(
    var.tags,
    {
      Name = "${title(var.service_name)}LaunchTemplate"
    }
  )
}
