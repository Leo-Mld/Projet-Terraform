terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.69.0"
    }
  }
}

provider "aws" {
  profile = var.aws_profile
  region  = "us-west-2"
}

data "aws_vpc" "selected" {
  id = "vpc-00b3d790fca3da129"
}
