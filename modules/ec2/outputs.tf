output "app-server-id" {
  description = "id of ec2 instance"
  value = aws_instance.app_server.id
  
}

output "ec2-sg-id" {
  description = "security group id"
  value = aws_security_group.ec2sg.id
  
}

  
