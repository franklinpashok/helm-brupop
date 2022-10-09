variable "standard_tags" {
  description = "Standard tags. If value is not applicable leave as empty or null."
  type = object({
    env : string
    app_tier : string
    appteam : string
    cost_centre : string
    product : string
    biz_dept : string
  })

  validation {
    condition     = can(regex("^dev$|^qa$|^uat$|^prd$", var.standard_tags.env))
    error_message = "Err: invalid env, must be one of dev|qa|uat|prd."
  }

  validation {
    condition     = can(regex("^[1-3]", var.standard_tags.app_tier))
    error_message = "Err: invalid app tier, must be one 1|2|3."
  }

  validation {
    condition     = can(regex("\\d{4}", var.standard_tags.cost_centre))
    error_message = "Err: invalid cost-centre, must be 4 digits."
  }
}

variable "map_migrated" {
  description = "Map-migrated discount code"
  type        = string
  default     = "d-server-00fyc0pr7gc8hv"
}

variable "ecr_max_untagged_images_count" {
  description = "Maximum number of untagged image to keep"
  type        = number
  default     = "3"
}

variable "github_repo" {
  description = "Github repository name to configure OIDC"
  type        = string
}

variable "github_branches" {
  description = "List of branches to be added as subject claims"
  type        = list(string)
  default     = []
}

variable "organization_name" {
  description = "Name of the Organization"
  type        = string
  default     = "sph"
}
