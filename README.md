# DevOps Intern Final Assessment

## Project Overview
This project demonstrates an end-to-end DevOps workflow for a containerized NGINX web application.

## Project Structure
```
devops-intern-final/
├── app/
│   ├── Dockerfile
│   ├── index.html
│   └── nginx.conf
├── .github/workflows/ci.yml
├── nomad/nginx-app.nomad.hcl
├── monitoring/
│   ├── docker-compose.yaml
│   ├── loki-config.yaml
│   ├── promtail-config.yaml
│   └── loki_setup.md
├── scripts/
│   ├── healthcheck.sh
│   └── sysinfo.sh
└── README.md
```

## Docker
Build the application image:
```bash
docker build -t devops-intern-nginx:final -f app/Dockerfile .
```

Run the application on port 8080:
```bash
docker run -d --name devops-nginx -p 8080:80 devops-intern-nginx:final
```

## Health Check
Run:
```bash
bash scripts/healthcheck.sh
```
Expected result: `Health check passed: http://localhost:8080`

## CI/CD
GitHub Actions validates the Docker build automatically when changes are pushed to the repository.

## Nomad Deployment
The NGINX application is deployed to HashiCorp Nomad using `nomad/nginx-app.nomad.hcl`.

Validate the job:
```bash
nomad job validate nomad/nginx-app.nomad.hcl
```

Run the job:
```bash
nomad job run nomad/nginx-app.nomad.hcl
```

## Monitoring
The monitoring directory contains Loki and Promtail configuration for centralized logging and monitoring setup.

## Verification
The application has been verified through Docker, the health-check script, GitHub Actions CI, and Nomad deployment.

## Author
Kufoin Synthia Femuh
