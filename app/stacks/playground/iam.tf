data "aws_iam_policy_document" "ec2_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:DescribeTags",
      "ecs:CreateCluster",
      "ecs:DeregisterContainerInstance",
      "ecs:DiscoverPollEndpoint",
      "ecs:Poll",
      "ecs:RegisterContainerInstance",
      "ecs:StartTelemetrySession",
      "ecs:UpdateContainerInstancesState",
      "ecs:Submit*",
      "ecs:TagResource",
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "ec2_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "ec2_policy" {
  name   = "${title(var.service_name)}Policy"
  policy = data.aws_iam_policy_document.ec2_policy.json
}

resource "aws_iam_role" "ec2_role" {
  name               = "${title(var.service_name)}EC2Role"
  assume_role_policy = data.aws_iam_policy_document.ec2_role_policy.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ec2_role" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "${var.service_name}_ec2_profile"
  role = aws_iam_role.ec2_role.name
}
