resource "aws_ecs_cluster" "this" {
  name = var.ecs_cluster_name
}

resource "aws_autoscaling_group" "this" {
  name                = "${var.service_name}-asg"
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.subnet_a.id]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
}
