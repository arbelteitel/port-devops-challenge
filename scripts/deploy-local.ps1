#!/usr/bin/env pwsh

# Local deployment script for testing
$ErrorActionPreference = "Stop"

Write-Host "🚀 Building Docker image locally..." -ForegroundColor Green
Set-Location app
docker build -t fastapi-app:local .

Write-Host "🎯 Deploying with Helm..." -ForegroundColor Green
Set-Location ../

# Deploy using Helm for local testing
helm upgrade --install arbel-app ./helm `
  --set image.repository=fastapi-app `
  --set image.tag=local `
  --set nameOverride=arbel-app `
  --set fullnameOverride=arbel-app

Write-Host "⏳ Waiting for deployment..." -ForegroundColor Yellow
kubectl rollout status deployment/arbel-app

Write-Host "✅ Deployment complete!" -ForegroundColor Green
Write-Host "🌐 Service info:" -ForegroundColor Cyan
kubectl get services arbel-app

Write-Host ""
Write-Host "💡 To test locally:" -ForegroundColor Yellow
Write-Host "kubectl port-forward service/arbel-app 8080:80"
Write-Host "Then visit: http://localhost:8080" -ForegroundColor Cyan