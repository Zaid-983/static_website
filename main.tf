terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.1"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}


resource "aws_s3_bucket" "static-website9831" {
  bucket = "static-website9831"
}

resource "aws_s3_bucket_public_access_block" "static-website9831" {
  bucket = aws_s3_bucket.static-website9831.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "static-website9831" {
  bucket = aws_s3_bucket.static-website9831.id
  policy = jsonencode(
    {
    Version = "2012-10-17",
    Statement = [
        {
            Sid = "PublicReadGetObject",
            Effect = "Allow",
            Principal = "*",
            Action ="s3:GetObject",
            Resource = "arn:aws:s3:::${aws_s3_bucket.static-website9831.id}/*"
            
        }
    ]
}
  )
}

resource "aws_s3_bucket_website_configuration" "static-website9831" {
  bucket = aws_s3_bucket.static-website9831.id

  index_document {
    suffix = "index.html"
  }

 

}



resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.static-website9831.bucket
  source = "./index.html"
  key = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "style_css" {
  bucket = aws_s3_bucket.static-website9831.bucket
  source = "./style.css"
  key = "style.css"
  content_type = "text/css"
}


output "name" {
  value = aws_s3_bucket_website_configuration.static-website9831.website_endpoint
  
}

#resource "aws_instance" "my_fist_project" {
#    ami = "ami-0fd05997b4dff7aac"
#    instance_type = "t2.micro"
#    tags = {
#    creator="terraform"
#   }
#}





