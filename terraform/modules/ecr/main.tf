
resource "aws_ecr_repository" "repo" {
  for_each = toset(var.services)
  name     = each.key
}

variable "services" {
  description = "List of services to create ECR repos for"
  type        = list(string)
  default     = ["service-a", "service-b", "service-c"]
}

# output "repo_urls" {
#   description = "Map of ECR repository URLs keyed by service name"
#   value = { for k, v in aws_ecr_repository.repo : k => v.repository_url }
# }

output "repo_urls" {
  value = tolist(aws_ecr_repository.repo[*].repository_url)
}
