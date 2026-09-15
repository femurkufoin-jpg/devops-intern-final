# Monitoring

This directory contains monitoring configuration for the DevOps Intern Final Assessment.

## Prometheus

Prometheus is configured to scrape metrics from the local Nomad agent.

- Nomad address: 127.0.0.1:4646
- Metrics endpoint: /v1/metrics
- Scrape interval: 15 seconds

## Application Health Check

Run: bash scripts/healthcheck.sh

Expected result: Health check passed: http://localhost:8080
