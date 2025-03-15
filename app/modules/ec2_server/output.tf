output "ec2_key_pair" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}

output "ec2_ipv4" {
  value = aws_eip.this.public_ip
}

output "key_pair_file" {
  value = local_sensitive_file.access_key_pair.filename
}
