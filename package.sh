#!/bin/bash

set -e

STACK_NAME=CLSI-API-Bussines-Implement
BUCKET_NAME=ilab-deploymentbucket-dev
REGION=us-east-2

echo "Empaquetando..."
aws cloudformation package \
  --template-file serverless.yaml \
  --s3-bucket $BUCKET_NAME \
  --output-template-file packaged.yaml \
  --region $REGION

echo "Desplegando..."
aws cloudformation deploy \
  --template-file packaged.yaml \
  --stack-name $STACK_NAME \
  --capabilities CAPABILITY_IAM \
  --region $REGION

echo "Obteniendo URL del API..."
aws cloudformation describe-stacks \
  --stack-name $STACK_NAME \
  --query "Stacks[0].Outputs[0].OutputValue" \
  --output text \
  --region $REGION
