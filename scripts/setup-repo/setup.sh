#!/bin/bash

read -p "AWS Access Key ID: " access_key

read -p "AWS Secret Access Key ID: " secret_key

read -p "AWS Region (recommend: ap-southeast-1): " region

mkdir -p ~/.aws

cat <<EOF >>~/.aws/config
[profile personal-infra-admin]
region = $region

EOF

cat <<EOF >>~/.aws/credentials
[personal-infra-admin]
aws_access_key_id = $access_key
aws_secret_access_key = $secret_key

EOF

echo "\n"
echo "Profile 'personal-infra-admin' added to ~/.aws/config and ~/.aws/credentials."
