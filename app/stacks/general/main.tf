module "general_server_1" {
  source       = "../../modules/ec2_server"
  service_name = "personal-gp-service-01"
  #   user_data    = file("./files/setup-arm.sh")
}
