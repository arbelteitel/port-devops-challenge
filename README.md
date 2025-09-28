# Port DevOps Challenge

FastAPI app deployed to AWS EKS with Terraform and Helm.

## Structure
```
├── app/           # FastAPI application
├── terraform/     # Infrastructure as Code
├── helm/          # Kubernetes deployment
└── .github/       # CI/CD pipeline
```

## Endpoints
- `GET /` - Hello message
- `GET /health` - Health check

## Deploy
Push to main branch - GitHub Actions handles the rest.