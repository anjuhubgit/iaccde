resource "aws_s3_bucket" "main" {
  bucket = "${var.bucket_name}-${var.env}"
  #acl = "private"
  tags = {
    Name = "${var.bucket_name}-${var.env}"
    Environmet = var.env

  }
  
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Disabled"
  }
  
}
