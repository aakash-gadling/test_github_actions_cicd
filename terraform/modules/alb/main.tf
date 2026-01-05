resource "aws_lb" "this" {
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.subnet_ids
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

resource "aws_lb_target_group" "tg" {
  count    = 3
  name     = "tg-${count.index}"
  port     = 80
  protocol = "HTTP"
  vpc_id  = var.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener_rule" "rules" {
  count        = 3
  listener_arn = aws_lb_listener.http.arn
  priority     = count.index + 1

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg[count.index].arn
  }

  condition {
    path_pattern {
      values = ["/service${count.index + 1}/*"]
    }
  }
}
