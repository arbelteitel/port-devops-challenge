# port-devops-challenge

🚀 Overview
End-to-end DevOps solution implementing a production-ready CI/CD pipeline for a Pokemon API microservice on AWS EKS, featuring Infrastructure as Code, containerization, and Helm-based deployments.
🎯 Application Features
FastAPI Pokemon Service:

GET /health - Health check endpoint
GET /pokemon/{name} - Fetch Pokemon data from PokeAPI
GET /pokemon/random - Random Pokemon selection
GET /metrics - Prometheus metrics

```
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
```


# 🛠️ Prerequisites
AWS CLI configured with provided credentials
Terraform >= 1.5
kubectl >= 1.28
Helm >= 3.12
Docker >= 20.10

# Test endpoints
curl http://localhost:8000/health
curl http://localhost:8000/pokemon/pikachu
curl http://localhost:8000/pokemon/random
