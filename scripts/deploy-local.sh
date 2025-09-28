#!/bin/bash

# Local deployment script for testing
set -e

echo "🚀 Building Docker image locally..."
cd app
docker build -t fastapi-app:local .

echo "📦 Loading image to kind cluster (if using kind)..."
# kind load docker-image fastapi-app:local

echo "🎯 Deploying to Kubernetes..."
cd ../k8s

# Replace environment variables for local testing
export ECR_REGISTRY="fastapi-app"
export ECR_REPOSITORY=""
export IMAGE_TAG="local"

envsubst < deployment.yaml | kubectl apply -f -
kubectl apply -f service.yaml

echo "⏳ Waiting for deployment..."
kubectl rollout status deployment/fastapi-app

echo "✅ Deployment complete!"
echo "🌐 Service info:"
kubectl get services fastapi-service

echo ""
echo "💡 To test locally:"
echo "kubectl port-forward service/fastapi-service 8080:80"
echo "Then visit: http://localhost:8080"