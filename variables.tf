variable "region" {
    default = "ap-northeast-1"
}

variable "vpc" {
    default = "10.0.0.0/16"
}

variable "public_subnet_1" {
    default = "10.0.0.0/19"
}

variable "public_subnet_2" {
    default = "10.0.32.0/19"
}

variable "private_subnet_1" {
    default = "10.0.64.0/19"
}

variable "private_subnet_2" {
    default = "10.0.96.0/19"
}