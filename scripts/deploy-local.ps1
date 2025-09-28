# Local deployment script for Windows/PowerShell
Write-Host "🚀 Building Docker image locally..." -ForegroundColor Green

Set-Location app
docker build -t fastapi-app:local .

Write-Host "🎯 Deploying to Kubernetes..." -ForegroundColor Green
Set-Location ../k8s

# Set environment variables for local testing
$env:ECR_REGISTRY = "fastapi-app"
$env:ECR_REPOSITORY = ""
$env:IMAGE_TAG = "local"

# Deploy using envsubst equivalent (manual replacement for Windows)
(Get-Content deployment.yaml) -replace '\$\{ECR_REGISTRY\}', $env:ECR_REGISTRY -replace '\$\{ECR_REPOSITORY\}', $env:ECR_REPOSITORY -replace '\$\{IMAGE_TAG\}', $env:IMAGE_TAG | kubectl apply -f -

kubectl apply -f service.yaml

Write-Host "⏳ Waiting for deployment..." -ForegroundColor Yellow
kubectl rollout status deployment/fastapi-app

Write-Host "✅ Deployment complete!" -ForegroundColor Green
Write-Host "🌐 Service info:" -ForegroundColor Cyan
kubectl get services fastapi-service

Write-Host ""
Write-Host "💡 To test locally:" -ForegroundColor Yellow
Write-Host "kubectl port-forward service/fastapi-service 8080:80"
Write-Host "Then visit: http://localhost:8080" -ForegroundColor Cyan