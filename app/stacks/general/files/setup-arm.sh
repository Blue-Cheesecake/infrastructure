#!/bin/bash

# install caddy
wget https://github.com/caddyserver/caddy/releases/download/v2.9.1/caddy_2.9.1_linux_arm64.tar.gz
tar -xf caddy_2.9.1_linux_arm64.tar.gz
sudo mv caddy /usr/bin
rm *

sudo groupadd --system caddy
sudo useradd --system \
    --gid caddy \
    --create-home \
    --home-dir /var/lib/caddy \
    --shell /usr/sbin/nologin \
    --comment "Caddy web server" \
    caddy

sudo mkdir /etc/caddy
sudo touch /etc/caddy/Caddyfile
sudo chown -R caddy:caddy /etc/caddy/
cat <<EOF | sudo tee /etc/caddy/Caddyfile
localhost:8080 {
    respond "Test test"
}
EOF
caddy trust

cat <<EOF | sudo tee /etc/systemd/system/caddy.service
[Unit]
Description=Caddy
Documentation=https://caddyserver.com/docs/
After=network.target network-online.target
Requires=network-online.target

[Service]
Type=notify
User=caddy
Group=caddy
ExecStart=/usr/bin/caddy run --environ --config /etc/caddy/Caddyfile
ExecReload=/usr/bin/caddy reload --config /etc/caddy/Caddyfile --force
TimeoutStopSec=5s
LimitNOFILE=1048576
PrivateTmp=true
ProtectSystem=full
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
EOF
sudo chown -R caddy:caddy /etc/systemd/system/caddy.service
sudo systemctl enable caddy
sudo systemctl start caddy

# install Docker
sudo yum update -y
sudo yum install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user
