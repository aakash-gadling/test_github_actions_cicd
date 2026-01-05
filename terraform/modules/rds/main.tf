resource "aws_db_subnet_group" "this" {
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "password123"
  db_subnet_group_name = aws_db_subnet_group.this.name
  skip_final_snapshot  = true
}
