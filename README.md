# DevOps Intern Final Assessment

## Project Overview

End-to-end deployment and automation of a containerized NGINX web application using Docker, GitHub Actions, HashiCorp Nomad, and Prometheus monitoring.

## Repository Structure

```text
devops-intern-final/
├── .github/
│   └── workflows/
│       └── ci.yml
├── app/
│   ├── Dockerfile
│   ├── index.html
│   └── nginx.conf
├── docs/
│   └── screenshots/
├── monitoring/
│   ├── prometheus.yml
│   └── README.md
├── nomad/
│   └── app.nomad
├── scripts/
│   ├── healthcheck.sh
│   └── sysinfo.sh
├── .gitignore
└── README.md