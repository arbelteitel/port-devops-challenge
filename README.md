# Port DevOps Challenge

ok so... thats my task 👐
we have here an EKS running my insanely comlpex app, with a working CI/CD via GitHub Actions (first time using it tbh).

if you have any questions regarding my choices - please ask me!

note:
ci is quite long because of cross-compilation, it would have been much easier to build the image directly to ARM, but since my GitHub is not a paid user, I don't have constant access to that feature - so I've decided to drop it for consistency.

now for the boring part


# Architecture Overview
aight, so the flow is pretty simple once you see it in action. I push my code to GitHub, and actions immediately picks it up and starts building the docker image. Now, I'm doing cross-compilation here to support both amd64 and arm64 architectures - it's a bit slow because I don't have access to GitHub's arm runners on the free tier, but it works consistently. Once the image is built, it gets pushed to AWS ecr (my private container registry). Then the cd part kicks in and deploys the new image to my eks cluster using kubectl. The app runs as a kubernetes deployment with a loadbalancer in front of it, so it's accessible from the outside world. Kubernetes handles the health checks and restarts anything that crashes, so it's pretty hands-off once it's running.

# Moving to Production
well, there's quite a bit to change for making this production-ready.
First off, secrets management needs work - storing everything in GitHub secrets is fine for this poc but not something for prod. Swapping in aws secrets manager or vault
would be the way to go. Monitoring is basically non-existent right now, so adding prometheus and grafana to actually see what's happening makes sense,
plus proper logging with cloudwatch or the elk stack. The infrastructure is already managed with terraform which is great, but bringing in terragrunt would handle multiple
environments more cleanly and keep the code DRY.
Security-wise, there is some work to be done. 
The cluster is public right now because it made testing easier for the poc, but in production that needs to be locked down with private subnets and a bastion
host or vpn access. Network policies to control traffic between pods, proper rbac instead of overly permissive roles, running containers as non-root,
that sort of thing. The ci/cd pipeline could use more stages too - automated tests, security scanning, maybe a staging environment before hitting prod, and instead of just doing rolling
updates, blue-green or canary deployments would catch issues before they hit everyone. 
speaking of finops - setting up aws budgets with alerts so we don't accidentally blow through money, and integrating kubecost to monitor what's 
actually spending at the kubernetes level. Right now the setup is probably running more resources than this simple app needs, so having that visibility would help optimize
costs without sacrificing reliability.

you can access the app over:
http://ad114c5ac83504d48a2d63e14b61623d-1512856565.eu-west-1.elb.amazonaws.com/
or
http://ad114c5ac83504d48a2d63e14b61623d-1512856565.eu-west-1.elb.amazonaws.com/health
