locals {
  standard_tags = merge(
    { for k, v in var.standard_tags : "sph:${replace(k, "_", "-")}" => v if v != null && v != "" },
    { map-migrated = var.map_migrated }
  )

  public_chart_names = {
    "bottlerocket-brupop" = {
    }
  }

}

module "helm_ecr_public" {
  source  = "terraform-aws-modules/ecr/aws"
  version = "~> 1.4.0"

  providers = {
    aws = aws.us_east_1
  }

  for_each = local.public_chart_names

  repository_name = "helm/${each.key}"
  repository_type = "public"

  repository_read_write_access_arns = [module.github_action_access.iam_role.arn]

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Keep last ${var.ecr_max_untagged_images_count} images",
        selection = {
          tagStatus   = "untagged",
          countType   = "imageCountMoreThan",
          countNumber = var.ecr_max_untagged_images_count
        },
        action = {
          type = "expire"
        }
      }
    ]
  })

  public_repository_catalog_data = {
    description       = "Helm chart for bottle rocket update operator"
    operating_systems = ["Linux"]
    architectures     = ["x86"]
  }

  tags = {
    "allow-gh-action" = true
  }
}

module "github_action_access" {
  source = "../../modules/github_oidc"

  github_repo     = var.github_repo
  github_branches = var.github_branches

  existing_openid_connect_provider_arn = data.aws_iam_openid_connect_provider.github.arn
}
