resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "10.20.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "sre-public-subnet-a"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.primary.id
  cidr_block              = "10.20.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "sre-public-subnet-b"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.primary.id
  cidr_block        = "10.20.11.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "sre-private-subnet-a"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.primary.id
  cidr_block        = "10.20.12.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "sre-private-subnet-b"
  }
}
