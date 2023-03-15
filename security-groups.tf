resource "aws_security_group" "instance_sg" {
  name_prefix = "demo-instance-sg"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #   ingress {
  #     description = "SSH"
  #     from_port   = 22
  #     to_port     = 22
  #     protocol    = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }

  #   ingress {
  #     description = "HTTP"
  #     from_port   = 80
  #     to_port     = 80
  #     protocol    = "tcp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }

  #   ingress {
  #     description = "icmp"
  #     from_port   = 0
  #     to_port     = 0
  #     protocol    = "icmp"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }

  egress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}