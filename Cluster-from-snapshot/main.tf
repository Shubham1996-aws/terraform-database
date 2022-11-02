data "aws_db_cluster_snapshot" "development_final_snapshot" {
  db_cluster_identifier = "aurora-cluster-demo"
  most_recent           = true
}

data "aws_db_subnet_group" "database" {
  name = "main"
}



data "aws_security_group" "my-sg" {
  name        = "allow_tls"
}






resource "aws_rds_cluster" "aurora" {
  cluster_identifier   = "development-cluster"
  snapshot_identifier  = data.aws_db_cluster_snapshot.development_final_snapshot.id
  db_subnet_group_name = data.aws_db_subnet_group.database.name
  engine                  = data.aws_db_cluster_snapshot.development_final_snapshot.engine
  engine_version          = data.aws_db_cluster_snapshot.development_final_snapshot.engine_version
  master_username         = "admin"
  master_password         = "admin12345678"
  skip_final_snapshot = true
  port = 3306
  vpc_security_group_ids = [data.aws_security_group.my-sg.id]
  tags = {
    Name = "Mydatabase"
  }


  lifecycle {
    ignore_changes = [snapshot_identifier]
  }
}


resource "aws_rds_cluster_instance" "aurorainstance" {
  cluster_identifier   = aws_rds_cluster.aurora.id
  instance_class       = "db.t3.medium"
  db_subnet_group_name = data.aws_db_subnet_group.database.name
  engine                  = data.aws_db_cluster_snapshot.development_final_snapshot.engine
  engine_version          = data.aws_db_cluster_snapshot.development_final_snapshot.engine_version
  publicly_accessible = true
  count              = 2
  identifier         = "aurora-cluster-demo-new-${count.index}"
}