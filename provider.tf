terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
  backend "s3" {
    bucket = "upgrad-12213" //s3 bucket name
    key    = "states/terraform.tfstate"//s3 bucket object to store the tfstate are change globally
    region = "us-east-1"
    dynamodb_table = "terraform"//dynamodb name
  }

}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}