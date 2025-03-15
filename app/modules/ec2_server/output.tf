output "ec2_key_pair" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}

output "ec2_ipv4" {
  value = aws_eip.this.public_ip
}
