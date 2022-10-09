provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"

  ignore_tags {
    key_prefixes = ["ams:rt:"]
    keys         = ["Patch Group"]
  }
}

provider "aws" {
  region = "ap-southeast-1"

  default_tags {
    tags = local.standard_tags
  }

  ignore_tags {
    keys         = ["Patch Group"]
    key_prefixes = ["ams:rt:"]
  }
}
