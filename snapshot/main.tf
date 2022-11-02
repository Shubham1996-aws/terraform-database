terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.34.0"
    }
  }
}

provider "aws" {
  region = var.region
  profile = "shubham"
}

variable "region" {
    default = "ap-northeast-1"
}

data "aws_rds_cluster" "aurora-cluster-demo" {
  cluster_identifier = "aurora-cluster-demo"
}

resource "aws_db_cluster_snapshot" "demo" {
  db_cluster_identifier          = data.aws_rds_cluster.aurora-cluster-demo.id
  db_cluster_snapshot_identifier = "test"
}