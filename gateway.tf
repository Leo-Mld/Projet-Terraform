resource "aws_internet_gateway" "gw" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = "main-gw"
  }
}


resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public-subnet.id

  tags = {
    Name = "nat gateway"
  }

  depends_on = [aws_internet_gateway.gw]
}
