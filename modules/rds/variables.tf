variable "env" {
  description = "Environment name ex:dev,prod"
  type = string
  
}
variable "vpc_id" {
  description = "id of vpc"
  type = string
  
}
variable "subnet_ids" {
  description = "subnet id"
  type = list(string)
  
}
variable "instance_class" {
  description = "instance class"
  type = string
  
}

variable "db_password" {
  description = "db password"
  type = string
  
}
variable "app_security_group_id" {
  description = "ID of the application server security group to allow ingress"
  type        = string
  
}
