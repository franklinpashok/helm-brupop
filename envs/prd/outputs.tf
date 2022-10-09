output "public_repository_arn" {
  description = "Full ARN of the public repository"
  value       = { for k, v in local.public_chart_names : k => module.helm_ecr_public[k].repository_arn }
}

output "public_repository_registry_id" {
  description = "The registry ID where the public repository was created"
  value       = { for k, v in local.public_chart_names : k => module.helm_ecr_public[k].repository_registry_id }
}

output "public_repository_url" {
  description = "The URL of the public repository"
  value       = { for k, v in local.public_chart_names : k => module.helm_ecr_public[k].repository_url }
}
