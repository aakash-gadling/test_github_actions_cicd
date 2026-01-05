terraform {
  backend "s3" {
    bucket         = "akku573"
    key            = "tf_test_statefile/ecs/dev/terraform.tfstate"
    region         = "ap-south-1"
  }
}
