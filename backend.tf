terraform {
  backend "s3" {
    bucket       = "my-bucket-name"
    encrypt      = true
    key          = "dev/jenkins/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}
