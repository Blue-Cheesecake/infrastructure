output "key_pair" {
  value = nonsensitive(module.general_server_1.ec2_key_pair)
}

output "ipv4" {
  value = module.general_server_1.ec2_ipv4
}

output "name" {
  value = module.general_server_1.ec2_tags["Name"]
}

output "instance_type" {
  value = module.general_server_1.ec2_instance_type
}
