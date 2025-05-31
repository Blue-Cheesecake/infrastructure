variable "tags" {
  default = {
    Service = "playground"
    Env     = "dev"
  }
}

variable "service_name" {
  default = "playground"
}

variable "ecs_cluster_name" {
  default = "TODO_JAH"
}
