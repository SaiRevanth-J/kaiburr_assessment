resource "aws_route_table" "pubilc_route" {
  vpc_id = aws_vpc.myvpc.id

  route {
     cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }
tags = {
  "Name" = "public"
}
}

resource "aws_route_table_association" "pubilc_assoc" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.pubilc_route.id
}
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.myvpc.id

 
tags = {
  "Name" = "private"
}
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_route.id
}