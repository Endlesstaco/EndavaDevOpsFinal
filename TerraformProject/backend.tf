terraform {
  backend "s3" {
    bucket         = "terraform-bucker"
    key            = "terraform.tfstate"
    region         = "eu-central-1"
  }
}

