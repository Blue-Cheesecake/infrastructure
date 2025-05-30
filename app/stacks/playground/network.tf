resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/24"

  tags = var.tags

  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet_a" {
  vpc_id               = aws_vpc.this.id
  cidr_block           = "10.0.0.0/24"
  availability_zone_id = "apse7-az1"

  tags = var.tags
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = var.tags
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = var.tags
}

resource "aws_route_table_association" "this" {
  route_table_id = aws_route_table.this.id
  subnet_id      = aws_subnet.subnet_a.id
}
