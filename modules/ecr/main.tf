resource "aws_ecr_repository" "main" {
  name = "${var.repo_name}-${var.env}"
  tags = {
    Name =  "${var.repo_name}-${var.env}"
    Environment = var.env
  }
}
