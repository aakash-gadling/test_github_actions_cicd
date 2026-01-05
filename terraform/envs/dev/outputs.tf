output "repo_urls" {
  description = "ECR repo URLs per service"
  value       = module.ecr.repo_urls
}
