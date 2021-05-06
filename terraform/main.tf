data "aws_ssm_parameter" "internal_app_baseurl" {
  name = "internal-app-${var.ENV}-endpoint-url"
}

resource "null_resource" "deployment_script" {
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "source ./bin/build.sh"
    environment = {
      VERSION  = var.VERSION
      BUCKET   = data.aws_ssm_parameter.serverless_bucket_name.value
      APP_NAME = var.APP_NAME
    }
  }
}
module "serverless-api" {
  source           = "github.com/brennanmeadowcroft/tf-poc-modules/serverless-api/"
  APP_NAME         = var.APP_NAME
  ENV              = var.ENV
  ARTIFACT_S3_KEY  = "${var.APP_NAME}/${var.VERSION}.zip"
  PATH_TO_ARTIFACT = "./build/${var.APP_NAME}.zip"
  ENVIRONMENT_VARS = {
    INTERNAL_APP_BASEURL = data.aws_ssm_parameter.internal_app_baseurl.value
  }
}
