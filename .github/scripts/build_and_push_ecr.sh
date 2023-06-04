#!/bin/bash

# Usage: ./build_and_push_ecr.sh <root_dir> <aws-region> <aws-account-id> <image_repo_name> <image_tag>

ROOT_DIR=$1
AWS_REGION=$2
AWS_ACCOUNT_ID=$3
IMAGE_REPO_NAME=$4
IMAGE_TAG=$5

cd "${ROOT_DIR}" || exit

echo "Logging in to Amazon ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com

echo "Building image..."
docker build -f ./.docker/Dockerfile -t $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_REPO_NAME:$IMAGE_TAG .

echo "Pushing image to ECR..."
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_REPO_NAME:$IMAGE_TAG
