output "db_password" {
    description = "password"
    value = aws_secretsmanager_secret.db_password.name
    }