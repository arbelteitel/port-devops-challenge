# Port DevOps Challenge

ok so... thats my task 👐
we have here an EKS running my insanely comlpex app, with a working CI/CD via GitHub Actions (first time using it tbh).

if you have any questions regarding my choices - please ask me!

note:
ci is quite long because of cross-compilation, it would have been much easier to build the image directly to ARM, but since my GitHub is not a paid user, I don't have constant access to that feature - so I've decided to drop it for consistency.

now for the boring part


# Architecture Overview
aight, so the flow is pretty simple once you see it in action. I push my code to GitHub, and actions immediately picks it up and starts building the docker image. Now, I'm doing cross-compilation here to support both amd64 and arm64 architectures - it's a bit slow because I don't have access to GitHub's arm runners on the free tier, but it works consistently. Once the image is built, it gets pushed to AWS ecr (my private container registry). Then the cd part kicks in and deploys the new image to my eks cluster using kubectl. The app runs as a kubernetes deployment with a loadbalancer in front of it, so it's accessible from the outside world. Kubernetes handles the health checks and restarts anything that crashes, so it's pretty hands-off once it's running.

# Moving to Production:
Honestly, there's quite a bit I'd change to make this production-ready. First off, secrets management needs work - storing everything in GitHub secrets is fine for this poc but not something I'd do in prod. I'd swap in aws secrets manager or vault. Monitoring is basically non-existent right now, so I'd add prometheus and grafana to actually see what's happening, plus proper logging with cloudwatch or the elk stack. The infrastructure should really be managed with terraform instead of being set up manually - that way everything's reproducible and tracked in git.
Security-wise, there's a lot of low-hanging fruit. Network policies to control traffic between pods, proper rbac instead of overly permissive roles, running containers as non-root, that sort of thing. The ci/cd pipeline needs more stages too - automated tests, security scanning, maybe a staging environment before hitting prod. And instead of just doing rolling updates, I'd implement blue-green or canary deployments so we can catch issues before they hit everyone. Oh, and cost optimization - right now I'm probably running more resources than this simple app needs, so autoscaling based on real metrics and maybe using spot instances where it makes sense would help keep costs reasonable.
