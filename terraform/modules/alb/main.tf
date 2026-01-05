resource "aws_lb" "this" {
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = [aws_lb_target_group.alb.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_target_group" "this" {
  for_each = toset(var.services)

  name        = each.key      # MUST match the service name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
}


resource "aws_lb_listener_rule" "rules" {
  for_each = aws_lb_target_group.this

  listener_arn = aws_lb_listener.http.arn
  priority     = 100 + index(var.services, each.key)

  action {
    type             = "forward"
    target_group_arn = each.value.arn
  }

  condition {
    path_pattern {
      values = ["/${each.key}/*"]
    }
  }
}

