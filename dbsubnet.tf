resource "aws_db_subnet_group" "dbsubnet" {
  name       = "main"
  subnet_ids = ["${aws_subnet.public-1.id}", "${aws_subnet.public-2.id}"]
  #availability_zones = data.aws_availability_zones.available
  tags = {
    Name = "My DB subnet group"
  }
}