resource "aws_subnet" "public_1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-south-1a"

      tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "private_2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-south-1b"

      tags = {
    Name = "private_subnet_2"
  }
}
  