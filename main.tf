terraform {
  # backend "remote" {
  #   hostname     = "app.terraform.io"
  #   organization = "exampro-terraform"

  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
  cloud {
    organization = "exampro-terraform"

    workspaces {
      name = "terra-house-1"
    }
  }

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }
  }
}

provider "aws" {
  region     = var.region
}

provider "random" {}

resource "random_string" "bucket_name" {
  lower   = true
  upper = false
  length  = 32
  special = true
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result
}

output "random_bucket_name" {
  value = random_string.bucket_name.result
}