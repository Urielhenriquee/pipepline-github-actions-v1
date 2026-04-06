terraform {
  required_version = ">= 1.5.0"

  backend "s3" {
    bucket  = "uriel-remote-state"
    key     = "pipeline-github/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.39.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "urielhenrique"
      managed_by = "terraform"
    }
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "uriel-remote-state"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}
