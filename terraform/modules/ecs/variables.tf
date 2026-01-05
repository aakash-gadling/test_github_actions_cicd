variable "vpc_id" {
  description = "VPC ID for ECS"
  type        = string
}

variable "private_subnets" {
  description = "Private subnet IDs for ECS services"
  type        = list(string)
}

variable "alb_listener_arn" {
  description = "ALB listener ARN"
  type        = string
}

variable "target_group_arns" {
  description = "Target group ARNs for ECS services"
  type        = list(string)
}

variable "ecr_repo_urls" {
  description = "ECR repository URLs"
  type        = list(string)
}

variable "services" {}