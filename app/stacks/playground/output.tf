output "key_pair" {
  # NOTE: if should be sensitive nah 🥲
  value = nonsensitive(tls_private_key.this.private_key_pem)
}
