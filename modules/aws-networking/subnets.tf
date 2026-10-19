resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id                  = aws_vpc.primary.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.project_name}-${var.environment}-public-${each.key}"
    Environment = var.environment
    Project     = var.project_name
    Tier        = "public"
  }
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.primary.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name        = "${var.project_name}-${var.environment}-private-${each.key}"
    Environment = var.environment
    Project     = var.project_name
    Tier        = "private"
  }
}
