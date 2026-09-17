# DevOps Intern Final Assessment

## Project Overview

This project demonstrates an end-to-end DevOps workflow for a containerized NGINX web application.

The project covers Linux scripting, Docker containerization, GitHub Actions CI/CD, GitHub Container Registry (GHCR), HashiCorp Nomad deployment, and centralized container logging with Loki and Promtail.

## Project Structure

```text
devops-intern-final/
├── app/
│   ├── Dockerfile
│   ├── index.html
│   └── nginx.conf
├── .github/
│   └── workflows/
│       └── ci.yml
├── nomad/
│   └── nginx-app.nomad.hcl
├── monitoring/
│   ├── docker-compose.yaml
│   ├── loki-config.yaml
│   ├── promtail-config.yaml
│   └── loki_setup.md
├── scripts/
│   ├── healthcheck.sh
│   └── sysinfo.sh
├── .gitignore
└── README.md
```

## Docker

Build the application image:

```bash
docker build -t devops-intern-nginx:final -f app/Dockerfile .
```

Run the application on port 8080:

```bash
docker run -d --name devops-nginx -p 8080:8080 devops-intern-nginx:final
```

The application is served by NGINX at:

```text
http://localhost:8080
```

## Health Check

Run the health-check script:

```bash
bash scripts/healthcheck.sh
```

Expected result:

```text
Health check passed: http://localhost:8080
```

The NGINX container also provides a dedicated health endpoint:

```text
http://localhost:8080/healthz
```

## Linux Scripts

The project includes two Bash scripts:

### System Information

Run:

```bash
./scripts/sysinfo.sh
```

The script displays system information, disk usage, memory information when available, and Docker daemon status.

### Health Check

Run:

```bash
bash scripts/healthcheck.sh
```

The script checks whether the application endpoint is reachable and returns a non-zero exit code if the check fails.

Shell scripts are validated with ShellCheck.

## CI/CD

GitHub Actions automatically validates the project when changes are pushed to the repository.

The pipeline includes:

1. Shell script linting
2. Docker image build
3. Container health testing
4. Docker image publication to GitHub Container Registry (GHCR)

The published image uses the Git commit SHA as an immutable deployment tag.

Example:

```text
ghcr.io/femurkufoin-jpg/devops-intern-nginx:<COMMIT_SHA>
```

A `latest` tag is also published for convenience, while the commit SHA tag is used for reproducible deployments.

## Nomad Deployment

The NGINX application is deployed to HashiCorp Nomad using:

```text
nomad/nginx-app.nomad.hcl
```

The Nomad job accepts the container image as a variable. This allows the deployment to use the exact SHA-tagged image produced by the CI/CD pipeline.

After the image has been published by GitHub Actions, set the image using the commit SHA:

```bash
IMAGE_TAG="$(git rev-parse HEAD)"
IMAGE="ghcr.io/femurkufoin-jpg/devops-intern-nginx:${IMAGE_TAG}"
```

Validate the Nomad job:

```bash
nomad job validate -var="image=${IMAGE}" nomad/nginx-app.nomad.hcl
```

Run the Nomad job:

```bash
nomad job run -var="image=${IMAGE}" nomad/nginx-app.nomad.hcl
```

The Nomad deployment includes:

- Rolling updates
- Automatic rollback on unhealthy deployments
- HTTP health checks
- `/healthz` health endpoint
- Nomad service registration
- SHA-tagged container images

Check the deployment status:

```bash
nomad job status devops-intern-app
```

## Monitoring

The `monitoring/` directory contains Loki and Promtail configuration for centralized container logging.

Start the monitoring stack:

```bash
docker compose -f monitoring/docker-compose.yaml up -d
```

Loki is available at:

```text
http://localhost:3100
```

Promtail discovers Docker containers and forwards their logs to Loki.

Example LogQL query:

```text
{job="docker"}
```

The logs can also be queried through the Loki API.

Example:

```bash
curl -sG "http://localhost:3100/loki/api/v1/query_range" \
  --data-urlencode 'query={job="docker"}' \
  --data-urlencode "start=$(date -u -d '10 minutes ago' +%s%N)" \
  --data-urlencode "end=$(date -u +%s%N)" \
  --data-urlencode 'limit=10'
```

## Verification

The project has been verified through:

- Git and GitHub version control
- ShellCheck validation
- Docker image build
- NGINX container execution
- Application health checks
- GitHub Actions CI/CD
- GHCR image publication
- SHA-tagged image pull
- Nomad deployment
- Nomad HTTP service health check
- Loki log ingestion
- Promtail Docker service discovery

The Nomad deployment was successfully verified with one desired allocation, one placed allocation, one healthy allocation, and zero unhealthy allocations.

## Release

The final assessment release is tagged:

```text
v1.0.0
```

## Author

Kufoin Synthia Femuh