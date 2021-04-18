resource "aws_db_instance" "TerraDB" {
  allocated_storage    = 5
  engine               = "mysql"
  engine_version       = "8.0.20"
  instance_class       = "db.t2.micro"
  name                 = "TerraformDB"
  username             = "Root"
  password             = "Pickles124"
  parameter_group_name = "default.mysql8.0"
  availability_zone    = "eu-central-1c"
  db_subnet_group_name = aws_db_subnet_group.DBSubnet.id
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "DBSubnet" {
  name       = "main"
  subnet_ids = [aws_subnet.subnet_webserver.id, aws_subnet.subnet_webserver_asg.id]
}
