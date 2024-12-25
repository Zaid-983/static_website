#creating s3 bucket to stor state file
terraform {
    backend "s3" {
      bucket = "static-website-backend983"
      key = "backend/app-state"
      region = "eu-west-2"
    }
}

#creating dynomodb to enable the state file
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "app-state"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
