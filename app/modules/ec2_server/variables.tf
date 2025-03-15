variable "service_name" {
  description = "The service name for this server. It will be used for various resource such as VPC, Security Group, etc."
  type        = string
  default     = "app-service"
}

variable "env" {
  description = "Environment variable from `TS_ENV`"
  type        = string
  default     = "dev"
}

variable "ami_id" {
  description = "AWS Ami Id"
  type        = string
  default     = "ami-0e072138db73fa2a1"
}

variable "aws_instance_type" {
  type    = string
  default = "t4g.nano"
}

variable "aws_thailand_availability_zone_ids" {
  type = map(string)
  default = {
    1 = "apse7-az1",
    2 = "apse7-az2",
    3 = "apse7-az3"
  }
}

variable "aws_singapore_availability_zone_ids" {
  type = map(string)
  default = {
    1 = "apse1-az1"
    2 = "apse1-az2"
    3 = "apse1-az3"
  }
}

variable "aws_availability_zone_number" {
  type    = number
  default = 1
}

variable "instance_private_ip" {
  type    = string
  default = "10.0.0.10"
}

# variable "user_data" {
#   type    = string
#   default = ""
# }
