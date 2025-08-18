variable "env" {
  description = "Environment name ex: dev.prod"
  type = string
}

  variable "subnet_id" {
    description = "id"
    type = string
  }
  

# variable "vpc_id" {
#   description = "id"
#   type = string
  
# }

variable "ami_id" {
  description = "ami id "
  type = string
  
}
variable "instance_type" {
  description = "instance type"
  type = string
  
}
variable "keypair_name" {
  description = "key pair name"
  type = string
  
}