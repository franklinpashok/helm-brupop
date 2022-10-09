output "iam_role" {
  description = "The crated role for github actions that can be assumed for the configured repository."
  value       = module.github_actions_repo.role
}
