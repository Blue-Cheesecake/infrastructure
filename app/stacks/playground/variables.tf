variable "tags" {
  default = {
    Name    = "playground-vpc"
    Service = "playground"
    Env     = "dev"
  }
}

variable "service_name" {
  default = "playground"
}
