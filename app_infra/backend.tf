terraform {
  backend "s3" {
    bucket         = "tf-state-file-for-demo"
    key            = "infra/prod/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
