resource "aws_subnet" "public-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_1
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "public-1"
  }
}

resource "aws_subnet" "public-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.public_subnet_2
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "public-2"
  }
}

resource "aws_subnet" "private-1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_1
  availability_zone = "ap-northeast-1c"
  tags = {
    Name = "private-1"
  }
}

resource "aws_subnet" "private-2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = var.private_subnet_2
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "private-2"
  }
}


resource "aws_route_table_association" "public-1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public-2" {
  subnet_id      = aws_subnet.public-2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.private.id
}
