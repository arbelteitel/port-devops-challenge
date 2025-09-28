#!/bin/bash

# Local deployment script for testing
set -e

echo "🚀 Building Docker image locally..."
cd app
docker build -t fastapi-app:local .

echo "🎯 Deploying with Helm..."
cd ../

# Deploy using Helm for local testing
helm upgrade --install arbel-app ./helm \
  --set image.repository=fastapi-app \
  --set image.tag=local \
  --set nameOverride=arbel-app \
  --set fullnameOverride=arbel-app

echo "⏳ Waiting for deployment..."
kubectl rollout status deployment/arbel-app

echo "✅ Deployment complete!"
echo "🌐 Service info:"
kubectl get services arbel-app

echo ""
echo "💡 To test locally:"
echo "kubectl port-forward service/arbel-app 8080:80"
echo "Then visit: http://localhost:8080"