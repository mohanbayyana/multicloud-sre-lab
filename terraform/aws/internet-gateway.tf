resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.primary.id

  tags = {
    Name = "sre-internet-gateway"
  }
}
