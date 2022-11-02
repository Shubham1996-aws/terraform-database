resource "aws_rds_cluster" "rdsaurora" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.10.2"
  availability_zones      = ["ap-northeast-1a", "ap-northeast-1c"]
  database_name           = "mydb"
  master_username         = "admin"
  master_password         = "admin12345678"
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  engine_mode = "provisioned"
  #iops = 1000
  db_subnet_group_name = aws_db_subnet_group.dbsubnet.id
  deletion_protection = false
  skip_final_snapshot = true
  port = 3306
  vpc_security_group_ids = [aws_security_group.rds-sg.id]
  
  tags = {
    Name = "Mysql"
  }
}


resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = aws_rds_cluster.rdsaurora.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.rdsaurora.engine
  engine_version     = aws_rds_cluster.rdsaurora.engine_version
  publicly_accessible = true
}