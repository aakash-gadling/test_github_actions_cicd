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
  type = map(string)
}

variable "services" {
  type = list(string)
}

variable "ecr_repo_urls" {
  type = map(string)
}

variable "alb_security_group_id" {
  type = string
}

variable "image_tag" {
  description = "Docker image tag to deploy"
  type        = string
}
