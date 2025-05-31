resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/20"

  tags = merge(
    var.tags,
    {
      Name : "${var.service_name}-vpc"
    }
  )

  enable_dns_hostnames = true
}

resource "aws_subnet" "subnet_a" {
  vpc_id               = aws_vpc.this.id
  cidr_block           = "10.0.1.0/24"
  availability_zone_id = "apse7-az1"

  tags = merge(
    var.tags,
    {
      Name = "${var.service_name}-subnet-a"
    }
  )
}

resource "aws_subnet" "subnet_b" {
  vpc_id               = aws_vpc.this.id
  cidr_block           = "10.0.2.0/24"
  availability_zone_id = "apse7-az2"

  tags = merge(
    var.tags,
    {
      Name = "${var.service_name}-subnet-b"
    }
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    var.tags,
    {
      Name = "${var.service_name}-internet-gateway"
    }
  )
}

resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    var.tags,
    {
      Name = "${var.service_name}-route-table"
    }
  )
}

resource "aws_route_table_association" "subnet_a" {
  route_table_id = aws_route_table.this.id
  subnet_id      = aws_subnet.subnet_a.id
}

resource "aws_route_table_association" "subnet_b" {
  route_table_id = aws_route_table.this.id
  subnet_id      = aws_subnet.subnet_b.id
}
