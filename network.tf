resource "aws_subnet" "private-subnet" {
  vpc_id     = data.aws_vpc.selected.id
  cidr_block = "10.0.10.0/24"

  tags = {
    Name = "private-subnet" #route nat gateway 
  }
}


resource "aws_subnet" "public-subnet" {
  vpc_id     = data.aws_vpc.selected.id
  cidr_block = "10.0.20.0/24"

  tags = {
    Name = "public-subnet" #route internet gateway
  }
}

