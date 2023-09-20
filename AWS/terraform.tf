# Terraform Configs for AWS infrastructure
#
# Project: My Portfolio Terminal
#
# Author: Saman Saybani

terraform {
  cloud {
    organization = "samanxdevexp"
    workspaces {
      name = "aws-cloudenv"
    }
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>5.0.0"
    }
  }
}
