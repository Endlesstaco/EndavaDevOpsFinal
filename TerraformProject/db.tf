resource "aws_db_instance" "TerraDB" {
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "8.0.20"
  instance_class       = "db.t2.micro"
  name                 = "TerraformDB"
  username             = "Root"
  password             = "Pickles124"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}
