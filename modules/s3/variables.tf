variable "env" {
  description = "environment"
  type = string
  
}
variable "bucket_name" {
  description = "bucket name"
  type = string
  
}

variable "versioning_enabled" {
  description = "versioning"
  type = bool
  default = true
}