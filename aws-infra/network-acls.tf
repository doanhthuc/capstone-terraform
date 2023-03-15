resource "aws_network_acl" "public_nacl" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.public_1.id]

  ingress {
    protocol   = "-1"
    rule_no    = 10
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  #   ingress {
  #     protocol   = "tcp"
  #     rule_no    = 100
  #     action     = "allow"
  #     cidr_block = "0.0.0.0/0"
  #     from_port  = 22
  #     to_port    = 22
  #   }

  #   ingress {
  #     protocol   = "icmp"
  #     rule_no    = 200
  #     action     = "allow"
  #     cidr_block = "0.0.0.0/0"
  #     from_port  = 0
  #     to_port    = 0
  #   }

  #   egress {
  #     protocol   = "tcp"
  #     rule_no    = 100
  #     action     = "allow"
  #     cidr_block = "0.0.0.0/0"
  #     from_port  = 1024
  #     to_port    = 65535
  #   }

  egress {
    protocol   = "-1"
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "demo-public-nacl"
  }
}