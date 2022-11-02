resource "aws_vpc" "vpc" {
  cidr_block = var.vpc
  enable_dns_hostnames = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

/*resource "aws_subnet" "private-1" {
  vpc_id     = aws_vpc.rds-vpc.id
  cidr_block = var.subnet-1

  tags = {
    Name = "MY-VPC"
  }
}*/

resource "aws_eip" "eip" {
  vpc      = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "gw"
  }
}
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-1.id

  tags = {
    Name = "NAT"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "public-route-table-1"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id

  route {
      cidr_block                 = "0.0.0.0/0"
      nat_gateway_id             = aws_nat_gateway.ngw.id
    }
  

  tags = {
    Name = "private-nat"
  }
}