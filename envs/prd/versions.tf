terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  cloud {
    organization = "sph"
    workspaces {
      name = "platform-eng-helm-bottle-rocket"
    }
  }
}
