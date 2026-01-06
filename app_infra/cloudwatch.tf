resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${var.ecs_cluster_name}"
  retention_in_days = 14
}
