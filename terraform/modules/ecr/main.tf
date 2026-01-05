
resource "aws_ecr_repository" "repo" {
  for_each = toset(var.services)
  name     = each.key
}


