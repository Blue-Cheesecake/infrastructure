terraform {
  backend "s3" {
    bucket                 = "<%= expansion('personal-terraform-state-:ACCOUNT-:REGION') %>"
    key                    = "<%= expansion(':PROJECT/:APP/:ROLE/:EXTRA/:BUILD_DIR/:ENV/terraform.tfstate') %>"
    region                 = "<%= expansion(':REGION') %>"
    dynamodb_table         = "personal_terraform_locks"
    skip_region_validation = true # rm error in case of on region - "ap-southeast-7"
  }
}
