variable "env" {
    description = "environment name (ex: dev, prod)"
    type = string
  
}
variable "vpc_cidr" {
    description = "cidr block for vpc"
    type = string
  
}
variable "public_subnets_cidr" {
    description = "A list of cidr blocks for public subnets"
    type = list(string)
  
}
variable "private_subnets_cidr" {
    description = "A list of cidr blocks for private subnets"
    type = list(string)
  
}