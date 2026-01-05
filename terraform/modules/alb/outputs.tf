output "listener_arn" {
  description = "ALB listener ARN"
  value       = aws_lb_listener.http.arn
}
output "target_group_arns" {
  value = {
    for name, tg in aws_lb_target_group.this :
    name => tg.arn
  }
}

output "alb_security_group_id" {
  value = aws_security_group.alb.id
}
