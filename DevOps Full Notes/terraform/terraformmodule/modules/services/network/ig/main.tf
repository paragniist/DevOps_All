resource "aws_internet_gateway" "ig" {
  vpc_id = var.vpc_id
  tags = {
    "Name" = var.ig_name
  }
}
resource "aws_route_table" "igrt" {
  vpc_id = var.vpc_id
  route {
    gateway_id = aws_internet_gateway.ig.id
    cidr_block = var.route_cidr
  }
}
resource "aws_route_table_association" "igrtassoc" {
  route_table_id = aws_route_table.igrt.id
  subnet_id = var.vpc_subnet_id
}
