resource "aws_security_group" "ec2sg" {
  name = "${var.env}-ec2sg"
  #vpc_id = var.vpc_id
  

#inbound ssh rule from anywhere 
ingress {
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
#inbound http rule from anywhere
ingress{
  from_port = 80
  to_port = 80 
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

#all outbound traffic
egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
}
resource "aws_instance" "app_server" {
ami = var.ami_id
instance_type = var.instance_type
subnet_id = var.subnet_id
vpc_security_group_ids = [aws_security_group.ec2sg.id]
key_name = var.keypair_name
tags = {
  Name = "${var.env}-app-server"
  Environment = var.env
}
}
