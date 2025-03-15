module "general_server_1" {
  source                    = "../../modules/ec2_server"
  service_name              = "personal-gp-service-01"
  iam_instance_profile_name = aws_iam_instance_profile.this.name
}

resource "aws_iam_role" "pull_only_ecr" {
  name = "PersonalECRAccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

data "aws_iam_policy" "pull_only_ecr" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}

resource "aws_iam_role_policy_attachment" "pull_only_ecr" {
  role       = aws_iam_role.pull_only_ecr.name
  policy_arn = data.aws_iam_policy.pull_only_ecr.arn
}

resource "aws_iam_instance_profile" "this" {
  name = "personal-pg-service-ecr-access-profile"
  role = aws_iam_role.pull_only_ecr.name
}
