output "listener_arn" {
  description = "ALB listener ARN"
  value       = aws_lb_listener.http.arn
}

output "target_group_arns" {
  description = "ALB target group ARNs"
  value       = aws_lb_target_group.tg[*].arn
}