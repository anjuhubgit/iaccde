variable "aws_region" {
  description = "region"
  type = string
  default = "us-east-1"
  
}
variable "env" {
  description = "The environment name"
  type        = string
  default     = "dev"
}
# variable "vpc_id" {
#   description = "id"
#   type = string
  
# }

variable "db_password" {
  description = "The database password for the dev environment"
  type        = string
  sensitive   = true
}