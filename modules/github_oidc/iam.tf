data "aws_iam_policy_document" "ecr_public" {
  statement {
    sid = "GetAuthorizationToken"

    actions = [
      "ecr-public:GetAuthorizationToken",
      "sts:GetServiceBearerToken"
    ]

    resources = ["*"]
  }

  statement {
    sid = "ManageRepositoryContents"

    actions = [
      "ecr-public:BatchCheckLayerAvailability",
      "ecr-public:GetRepositoryPolicy",
      "ecr-public:DescribeRepositories",
      "ecr-public:DescribeImages",
      "ecr-public:InitiateLayerUpload",
      "ecr-public:UploadLayerPart",
      "ecr-public:CompleteLayerUpload",
      "ecr-public:PutImage",
    ]

    resources = ["arn:aws:ecr::${data.aws_caller_identity.current.account_id}:repository/${var.namespace}/*"]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/allow-gh-action"

      values = ["true"]
    }
  }
}

resource "aws_iam_role_policy" "ecr_public" {
  name = "ecr-public-access"
  role = module.github_actions_repo.role.name

  policy = data.aws_iam_policy_document.ecr_public.json
}
