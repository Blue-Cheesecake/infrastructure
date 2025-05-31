variable "tags" {
  default = {
    Service = "playground"
    Env     = "dev"
  }
}

variable "service_name" {
  default = "playground"
}
