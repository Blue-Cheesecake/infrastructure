resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/24"

  tags = {
    Name : "${var.service_name}-${var.env}-vpc"
    Service : var.service_name
    Env : var.env
  }

  enable_dns_hostnames = true
}

resource "aws_subnet" "this" {
  vpc_id               = aws_vpc.this.id
  cidr_block           = "10.0.0.0/24"
  availability_zone_id = var.aws_thailand_availability_zone_ids[var.aws_availability_zone_number]

  tags = {
    Name : "${var.service_name}-${var.env}-subnet-a"
    Service : var.service_name
    Env : var.env
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name : "${var.service_name}-${var.env}-internet-gateway"
    Service : var.service_name
    Env : var.env
  }
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name : "${var.service_name}-${var.env}-route-table"
    Service : var.service_name
    Env : var.env
  }
}

resource "aws_route_table_association" "this" {
  route_table_id = aws_route_table.this.id
  subnet_id      = aws_subnet.this.id
}

resource "aws_security_group" "this" {
  name        = "${var.service_name}-${var.env}-security-group"
  description = "Allow TLS ingress and all egress"
  vpc_id      = aws_vpc.this.id

  tags = {
    "Name" : "${var.service_name}-security-group",
    "Service" : var.service_name,
    "Env" : var.env,
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = "443"
  to_port           = "443"

  tags = {
    "Name" : "allow-tls-ipv4"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = "80"
  to_port           = "80"

  tags = {
    "Name" : "allow-http-ipv4"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = "22"
  to_port           = "22"

  tags = {
    "Name" : "allow-all-ssh"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_ipv4" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"

  tags = {
    "Name" : "allow-all-ipv4"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.this.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"

  tags = {
    "Name" : "allow-all-ipv6"
  }
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "this" {
  key_name   = "${var.service_name}-${var.env}-key-pair"
  public_key = tls_private_key.this.public_key_openssh
}

resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.aws_instance_type
  key_name               = aws_key_pair.this.key_name
  subnet_id              = aws_subnet.this.id
  vpc_security_group_ids = [aws_security_group.this.id]
  private_ip             = var.instance_private_ip
  iam_instance_profile   = var.iam_instance_profile_name
  user_data              = var.user_data

  tags = {
    Name : "${var.service_name}-${var.env}-instance"
    Service : var.service_name
    Env : var.env
  }
}

resource "aws_eip" "this" {
  instance = aws_instance.this.id
  domain   = "vpc"

  tags = {
    Name : "${var.service_name}-${var.env}-eip"
    Service : var.service_name
    Env : var.env
  }
}
