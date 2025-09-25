# port-devops-challenge

🚀 Overview
End-to-end DevOps solution implementing a production-ready CI/CD pipeline for a Pokemon API microservice on AWS EKS, featuring Infrastructure as Code, containerization, and Helm-based deployments.
🎯 Application Features
FastAPI Pokemon Service:

GET /health - Health check endpoint
GET /pokemon/{name} - Fetch Pokemon data from PokeAPI
GET /pokemon/random - Random Pokemon selection
GET /metrics - Prometheus metrics

port-devops-challenge/
├── app/                        # FastAPI Pokemon Service
│   ├── src/
│   │   └── main.py            # FastAPI with Pokemon endpoints
│   ├── Dockerfile             # Multi-stage container build
│   ├── requirements.txt       # Python dependencies
│   └── .dockerignore
├── infrastructure/             # Terraform Infrastructure
│   ├── modules/
│   │   ├── networking/        # VPC, subnets, security groups
│   │   ├── eks/               # EKS cluster configuration
│   │   └── ecr/               # Container registry
│   ├── environments/
│   │   ├── dev/
│   │   └── prod/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── helm/                      # Helm Charts
│   └── pokemon-service/
│       ├── Chart.yaml
│       ├── values.yaml
│       ├── values-dev.yaml
│       ├── values-prod.yaml
│       └── templates/
├── .github/workflows/         # CI/CD Pipelines
│   ├── infrastructure.yml    # Terraform deployment
│   ├── application.yml       # App build & deploy
│   └── helm-lint.yml        # Chart validation
├── docs/                     # Documentation
│   ├── architecture-diagram.png
│   └── production-recommendations.md
└── README.md                 # This file


🛠️ Prerequisites

AWS CLI configured with provided credentials
Terraform >= 1.5, kubectl >= 1.28, Helm >= 3.12, Docker >= 20.10

🚦 Quick Start
bash# 1. Deploy Infrastructure
cd infrastructure/environments/dev
terraform init && terraform apply

# 2. Configure kubectl
aws eks update-kubeconfig --region us-west-2 --name port-eks-cluster

# 3. Deploy Pokemon Service
helm upgrade --install pokemon-service ./helm/pokemon-service
🔧 Local Development
bashcd app
pip install -r requirements.txt
uvicorn src.main:app --reload --host 0.0.0.0 --port 8000

# Test endpoints
curl http://localhost:8000/health
curl http://localhost:8000/pokemon/pikachu
curl http://localhost:8000/pokemon/random
📈 Production Features

External API integration with PokeAPI
Error handling & retries for API calls
Caching for improved performance
Monitoring with health checks and metrics
Environment-specific configuration

⏱️ Implementation Timeline
Total: 10-15 hours across infrastructure, containerization, Helm charts, CI/CD, and documentation.

Status: 🚧 In Progress
