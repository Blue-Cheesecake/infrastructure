output "ec2_key_pair" {
  value = nonsensitive(module.general_server_1.ec2_key_pair)
}

output "ec2_ipv4" {
  value = module.general_server_1.ec2_ipv4
}
