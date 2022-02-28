resource "aws_route_table" "route-table-private-nat" {
  vpc_id = data.aws_vpc.selected.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "route-table-private-nat"
  }
}

resource "aws_route_table_association" "route-private" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.route-table-private-nat.id
}

resource "aws_route_table" "route-table-public" {
  vpc_id = data.aws_vpc.selected.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "route-table-public"
  }

}

resource "aws_route_table_association" "route-public" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.route-table-public.id
}
