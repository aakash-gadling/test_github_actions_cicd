resource "aws_ecs_cluster" "this" {
  name = "ecs-cluster"
}

resource "aws_ecs_task_definition" "task" {
  count                    = 3
  family                   = "service-${count.index}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  execution_role_arn = aws_iam_role.ecs_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "service-${count.index}"
      image = var.ecr_repo_urls[count.index]
      portMappings = [
        {
          containerPort = 80
        }
      ]
    }
  ])
}


resource "aws_ecs_service" "service" {
  count           = 3
  name            = "service-${count.index}"
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.task[count.index].arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = var.private_subnets
    assign_public_ip = false
    security_groups  = []
  }

  load_balancer {
    target_group_arn = var.target_group_arns[count.index]
    container_name   = "service-${count.index}"
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
