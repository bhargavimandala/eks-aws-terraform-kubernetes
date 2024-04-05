//create a VPC
 resource "aws_vpc" "mbr" {
   cidr_block = var.vpc-cidr

   tags = {
     Name = "mbr-vpc"
   }
 }
//create a 1ST subnet
resource "aws_subnet" "mbr_subnet-1" {
  vpc_id     = "${aws_vpc.mbr.id}"
  cidr_block = var.subnet1-cidr
  availability_zone = var.subnet-az-1
  map_public_ip_on_launch = "true"

  tags = {
    Name = "mbr-subnet-1"
  }
}

//create a 2nd subnet
resource "aws_subnet" "mbr_subnet-2" {
  vpc_id     = "${aws_vpc.mbr.id}"
  cidr_block = var.subnet2-cidr
  availability_zone = var.subnet-az-2
  map_public_ip_on_launch = "true"

  tags = {
    Name = "mbr-subnet-2"
  }
}

//create a internet gateway
resource "aws_internet_gateway" "mbr-igw" {
  vpc_id = "${aws_vpc.mbr.id}"

  tags = {
    Name = "mbr-internetgateway"
  }
}
// creat a route table

resource "aws_route_table" "mbr-rt" {
  vpc_id = "${aws_vpc.mbr.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.mbr-igw.id}"
  }
  tags={
    name = "mbr-rt"
  }
}
//associate subnet1 with routtable
resource "aws_route_table_association" "mbr-rt_association-1" {
  subnet_id      = "${aws_subnet.mbr_subnet-1.id}"
  route_table_id = aws_route_table.mbr-rt.id
}
//associate subnet2 with routtable
resource "aws_route_table_association" "mbr-rt_association-2" {
  subnet_id      = "${aws_subnet.mbr_subnet-2.id}"
  route_table_id = aws_route_table.mbr-rt.id
}
//security group
resource "aws_security_group" "mbr-vpc-sg" {
  name        = "mbr-vpc-sg"
  vpc_id      = aws_vpc.mbr.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
