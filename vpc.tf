//create a VPC
 resource "aws_vpc" "sbr" {
   cidr_block = var.vpc-cidr

   tags = {
     Name = "sbr-vpc"
   }
 }
//create a 1ST subnet
resource "aws_subnet" "sbr_subnet-1" {
  vpc_id     = "${aws_vpc.sbr.id}"
  cidr_block = var.subnet1-cidr
  availability_zone = var.subnet-az-1
  map_public_ip_on_launch = "true"

  tags = {
    Name = "sbr-subnet-1"
  }
}

//create a 2nd subnet
resource "aws_subnet" "sbr_subnet-2" {
  vpc_id     = "${aws_vpc.sbr.id}"
  cidr_block = var.subnet2-cidr
  availability_zone = var.subnet-az-2
  map_public_ip_on_launch = "true"

  tags = {
    Name = "sbr-subnet-2"
  }
}

//create a internet gateway
resource "aws_internet_gateway" "sbr-igw" {
  vpc_id = "${aws_vpc.sbr.id}"

  tags = {
    Name = "sbr-internetgateway"
  }
}
// creat a route table

resource "aws_route_table" "sbr-rt" {
  vpc_id = "${aws_vpc.sbr.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.sbr-igw.id}"
  }
  tags={
    name = "sbr-rt"
  }
}
//associate subnet1 with routtable
resource "aws_route_table_association" "sbr-rt_association-1" {
  subnet_id      = "${aws_subnet.sbr_subnet-1.id}"
  route_table_id = aws_route_table.sbr-rt.id
}
//associate subnet2 with routtable
resource "aws_route_table_association" "sbr-rt_association-2" {
  subnet_id      = "${aws_subnet.sbr_subnet-2.id}"
  route_table_id = aws_route_table.sbr-rt.id
}
//security group
resource "aws_security_group" "sbr-vpc-sg" {
  name        = "sbr-vpc-sg"
  vpc_id      = aws_vpc.sbr.id

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