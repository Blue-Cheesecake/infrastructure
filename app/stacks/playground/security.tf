resource "aws_security_group" "this" {
  name   = var.service_name
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      Name = "${var.service_name}-security-group"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = "443"
  to_port           = "443"

  tags = merge(
    var.tags,
    {
      Name = "${var.service_name}-allow-tls-ingress"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = "80"
  to_port           = 80

  tags = merge(
    var.tags,
    {
      Name = "${var.service_name}-allow-http-ingress"
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "allow_all_ipv4" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = merge(
    var.tags,
    {
      Name = "${var.service_name}-allow-all-ingress"
    }
  )
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.this.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"

  tags = merge(
    var.tags,
    {
      Name = "${var.service_name}-allow-all-egress"
    }
  )
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "this" {
  key_name   = "${var.service_name}-key"
  public_key = tls_private_key.this.public_key_openssh

  tags = merge(
    var.tags,
    {
      Name = "${var.service_name}-key-pair"
    }
  )
}
