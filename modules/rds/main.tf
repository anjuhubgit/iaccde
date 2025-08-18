resource "aws_db_subnet_group" "default" {
  subnet_ids = var.subnet_ids
  tags = {
    Name = "${var.env}-rds-subnet-group"
  }
  
}
resource "aws_security_group" "rds_sg" {
  name = "${var.env}-rds-sg"
  description = "allow inbound traffic from application server"
  vpc_id = var.vpc_id
  
#allow traffic from ec2 sg grp 
ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }

  # All outbound traffic for database updates.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
  Name = "${var.env}-db-instance"
  Environment = var.env
}

}



resource "aws_db_instance" "postgres" {
  identifier = "${var.env}-db-instance"
  engine = "postgres"
  engine_version = "13.4"
  instance_class = var.instance_class
  db_subnet_group_name = aws_db_subnet_group.default.id
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  allocated_storage = 20
  username = "postgres"
  password = var.db_password
  tags = {
    Name = "${var.env}-postgres-db"
    Environment = var.env
  }
  
}
