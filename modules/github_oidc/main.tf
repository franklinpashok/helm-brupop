module "github_actions_oidc_provider" {
  count = var.existing_openid_connect_provider_arn == "" || var.existing_openid_connect_provider_arn == null ? 1 : 0

  source  = "philips-labs/github-oidc/aws//modules/provider"
  version = "~> 0.2.2"
}

module "github_actions_repo" {
  source  = "philips-labs/github-oidc/aws"
  version = "~> 0.2.2"

  openid_connect_provider_arn = try(module.github_actions_oidc_provider[0].openid_connect_provider.arn, var.existing_openid_connect_provider_arn)
  repo                        = var.github_repo
  role_name                   = var.role_name
  default_conditions          = ["allow_environment", "allow_main"]
  github_environments         = ["prd"]

  conditions = (var.github_branches != []) ? [
    {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = [for branch in var.github_branches : "repo:${var.github_repo}:ref:refs/heads/${branch}"]
    },
  ] : []

}
