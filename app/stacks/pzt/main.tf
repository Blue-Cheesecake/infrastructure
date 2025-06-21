resource "aws_s3_bucket" "pzt_web" {
  bucket = "purezentos-website-${var.env}"

  force_destroy = true

  tags = merge(
    var.tags,
    {
      Env = var.env
    }
  )
}

resource "aws_s3_bucket_website_configuration" "pzt_web" {
  bucket = aws_s3_bucket.pzt_web.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

resource "aws_s3_bucket_public_access_block" "pzt_web" {
  bucket = aws_s3_bucket.pzt_web.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "pzt_web" {
  bucket = aws_s3_bucket.pzt_web.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.pzt_web.arn,
          "${aws_s3_bucket.pzt_web.arn}/*"
        ]
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.pzt_web]
}

resource "aws_s3_bucket_ownership_controls" "pzt_web" {
  bucket = aws_s3_bucket.pzt_web.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }

  depends_on = [aws_s3_bucket_public_access_block.pzt_web]
}

resource "aws_s3_bucket_acl" "pzt_web" {
  bucket = aws_s3_bucket.pzt_web.id

  acl = "public-read"

  depends_on = [aws_s3_bucket_ownership_controls.pzt_web, aws_s3_bucket_public_access_block.pzt_web]
}
