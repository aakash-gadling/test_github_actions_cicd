
resource "aws_ecr_repository" "repo" {
  for_each = toset(var.services)
  name     = each.key
}

variable "services" {
  description = "List of services"
  type        = list(string)
  default     = ["service-a", "service-b", "service-c"]
}

output "repo_urls" {
  description = "Map of service name to ECR repo URL"
  value = {
    for name, repo in aws_ecr_repository.repo :
    name => repo.repository_url
  }
}
