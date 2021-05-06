variable "AWS_REGION" {
  default = "us-west-2"
}

variable "ENV" {
  default = "dev"
}

variable "APP_NAME" {
  default = "external-app"
}

variable "VERSION" {
  type        = string
  description = "The version used for uploading the code build to S3"
}
