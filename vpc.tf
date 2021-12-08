# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "false"
  tags = {
    Name = "${terraform.workspace}-vpc"
  }
}

# Public subnet
resource "aws_subnet" "public-subnet-1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "${terraform.workspace}-public-subnet-1a"
  }
}

resource "aws_subnet" "public-subnet-1c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "${terraform.workspace}-public-subnet-1c"
  }
}

# Protected subnet
resource "aws_subnet" "protected-subnet-1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "${terraform.workspace}-protected-subnet-1a"
  }
}

resource "aws_subnet" "protected-subnet-1c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "${terraform.workspace}-protected-subnet-1c"
  }
}

# Private subnet
resource "aws_subnet" "private-subnet-1a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "${terraform.workspace}-private-subnet-1a"
  }
}

resource "aws_subnet" "private-subnet-1c" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "${terraform.workspace}-private-subnet-1c"
  }
}

# Internet gateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id     = aws_vpc.vpc.id
  depends_on = [aws_vpc.vpc]
  tags = {
    Name = "${terraform.workspace}-internet-gateway"
  }
}

# Route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }
  tags = {
    Name = "${terraform.workspace}-inet-rtbl"
  }
}

# Route
resource "aws_route" "public-route" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = "${aws_route_table.public-route-table.id}"
  gateway_id             = "${aws_internet_gateway.internet-gateway.id}"
}

# Route table association
resource "aws_route_table_association" "public-route-table-association-1a" {
  subnet_id      = aws_subnet.public-subnet-1a.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-route-table-association-1c" {
  subnet_id      = aws_subnet.public-subnet-1c.id
  route_table_id = aws_route_table.public-route-table.id
}
