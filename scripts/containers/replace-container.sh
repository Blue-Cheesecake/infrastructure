#!/bin/bash

set -e

echo "----------Container------------"
docker ps -a | grep <ct-name>

echo "------------Image--------------"
docker images | grep <ct-name>

echo "-------------------------------"

read -p "Existing container id: " container
read -p "Version: (x.y.z): " tag
read -p "Previous image id: " prev_image_id

echo "[INFO]: 🏃  logging in to ECR"
aws ecr get-login-password --region ap-southeast-7 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.ap-southeast-7.amazonaws.com
echo "[INFO]: ✅ login success"

echo "[INFO]: 🏃 pullling image"
docker pull <account-id>.dkr.ecr.ap-southeast-7.amazonaws.com<repo-name>
echo "[INFO]: ✅ image pulled"

echo "[INFO]: 🏃 stoping container $container"
docker stop $container
echo "[INFO]: ✅ container stopped"

echo "[INFO]: 🏃 removing container $container"
docker rm $container
echo "[INFO]: ✅ container removed"

echo "[INFO]: 🏃 removing image $prev_image_id"
docker image rm $prev_image_id
echo "[INFO]: ✅ image removed"

echo "[INFO]: 🏃 deploying"
docker run -d \
 <config>

echo "[INFO]: ✅ successfully deploying"
