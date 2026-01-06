variable "aws_region" {
  type    = string
  default = "ap-south-1"
}
variable "aws_account_id" {
  type = string
}
variable "image_name" {
  type = string
}
variable "image_tag" {
  type = string
}
variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}
variable "public_subnet_cidrs" {
  type = list(string)
  default = ["10.0.1.0/24","10.0.2.0/24"]
}
variable "az_count" {
  type    = number
  default = 2
}
variable "ecs_cluster_name" {
  type    = string
  default = "demo-ecs-cluster"
}
variable "app_port" {
  type    = number
  default = 5000
}
variable "task_cpu" {
  type    = number
  default = 512
}
variable "task_memory" {
  type    = number
  default = 1024
}
variable "desired_count" {
  type    = number
  default = 1
}
