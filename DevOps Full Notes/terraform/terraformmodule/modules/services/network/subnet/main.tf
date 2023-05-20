resource "aws_subnet" "subnet" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.az
  tags = {
    "Name" = var.subnet_name
  }
}