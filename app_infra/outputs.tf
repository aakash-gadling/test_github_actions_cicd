output "ecr_repository_url" {
  value = aws_ecr_repository.app_repo.repository_url
}
output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}
output "ecs_service_name" {
  value = aws_ecs_service.app_service.name
}
output "ecr_repository_name" {
  value = aws_ecr_repository.app_repo.name
}
output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}
