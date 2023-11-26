resource "aws_db_instance" "RDS" {
  identifier           = "db-instance-mysql"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "harshid"
  password             = "12345678"
  allocated_storage    = 10
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  publicly_accessible  = true
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [var.public_subnet_az1, var.public_subnet_az2]
  # vpc_id     = var.vpc_id
  tags = {
    Name = "My DB subnet group"
  }
}