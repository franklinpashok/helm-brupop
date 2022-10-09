variable "existing_openid_connect_provider_arn" {
  description = "Existing OpenID Connect provider ARN"
  type        = string
  default     = ""
}

variable "github_repo" {
  description = "GitHub repository to grant access to assume a role via OIDC."
  type        = string
}

variable "github_branches" {
  description = "List of github branches allowed for oidc subject claims."
  type        = list(string)
  default     = []
}

variable "role_name" {
  description = "(Optional) role name of the created role, if not provided the `namespace` will be used."
  type        = string
  default     = null
}

variable "namespace" {
  description = "Namespace to restrict the roles ECR privileges to."
  type        = string
  default     = "helm"
}
