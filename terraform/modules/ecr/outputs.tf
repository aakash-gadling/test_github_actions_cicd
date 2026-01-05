output "repo_urls" {
  description = "Map of service name to ECR repo URL"
  value = {
    for name, repo in aws_ecr_repository.repo :
    name => repo.repository_url
  }
}