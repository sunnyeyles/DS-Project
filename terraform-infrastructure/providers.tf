provider "aws" {
  region = var.region
}
provider "aws" {
  profile = "school-account"
  region  = "eu-west-3"
}