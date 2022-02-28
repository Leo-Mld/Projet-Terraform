data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_network_interface" "network-interface" {
  count = var.count_instances

  subnet_id       = aws_subnet.private-subnet.id
  private_ips     = ["10.0.10.${count.index + 4}"]
  security_groups = [aws_security_group.allow_http_from_elb.id]

  tags = {
    Name = "primary_network_interface ${count.index}"
  }
}

resource "aws_instance" "web" {
  count = var.count_instances

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  network_interface {
    network_interface_id = aws_network_interface.network-interface[count.index].id
    device_index         = 0
  }
  user_data = file("./script.sh")
  tags = {
    Name = "HelloWorld ${count.index}"
  }

  depends_on = [
    aws_route_table.route-table-private-nat,
    aws_route_table.route-table-public,
    aws_subnet.public-subnet,
    aws_subnet.private-subnet,
  ]
}
