resource "aws_instance" "ec2-bastion" {
  ami                         = var.ami-instance-type-bastion
  instance_type               = var.instance-type-bastion
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public_1.id
  key_name                    = "demo-vpc"
  security_groups             = [aws_security_group.instance_sg.id]

  tags = {
    Name = "${var.bastion-tag-name}"
  }
}