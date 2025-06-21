variable "env" {
  default = "dev"
}

variable "tags" {
  default = {
    Service   = "purezentos-web"
    CreatedBy = "terraform"
  }
}
