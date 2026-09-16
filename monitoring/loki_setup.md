# Loki and Promtail Setup

## Overview

Loki and Promtail are used to collect and query Docker container logs for the DevOps Intern Final Assessment.

## Components

- Loki: stores and serves log data.
- Promtail: reads Docker container logs and sends them to Loki.
- Docker: provides the application container logs.

## Start the Monitoring Stack

From the repository root, run:

    docker compose -f monitoring/docker-compose.yaml up -d

## Verify the Containers

Run:

    docker compose -f monitoring/docker-compose.yaml ps

## Log Labels

Promtail labels Docker logs with the job and container labels configured in promtail-config.yaml.

Example labels include:

    job="docker"
    container="devops-intern-nginx"

## LogQL Query

Use the following LogQL query to retrieve logs from the NGINX application:

    {job="docker", container="devops-intern-nginx"}

This query selects logs labelled with the docker job and the devops-intern-nginx container.

## Health Check

The application can also be checked with:

    bash scripts/healthcheck.sh

Expected result:

    Health check passed: http://localhost:8080
