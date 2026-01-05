resource "aws_ecs_cluster" "this" {
  name = "ecs-cluster"
}

resource "aws_ecs_task_definition" "task" {
  for_each = toset(var.services)

  family                   = each.key
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = each.key
      image = "${var.ecr_repo_urls[each.key]}:${var.image_tag}"
      # image = "${var.ecr_repo_urls[each.key]}:latest"

      portMappings = [
        {
          containerPort = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "service" {
  for_each = toset(var.services)

  name            = each.key
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.task[each.key].arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = var.private_subnets
    assign_public_ip = false
    security_groups  = [aws_security_group.ecs_tasks.id]
  }

  load_balancer {
    target_group_arn = var.target_group_arns[each.key]   # now keys match
    container_name   = each.key
    container_port   = 80
  }
}




resource "aws_iam_role" "ecs_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
