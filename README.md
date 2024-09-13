# Time API Deployment
# Overview
 This project demonstrates how to deploy a simple time API to Azure Kubernetes Service (AKS) using Terraform for Infrastructure as Code (IaC) and GitHub Actions for Continuous Deployment (CD).

## Steps
API Development

## Implemented in JavaScript using Express.
Dockerized the API using a Dockerfile.
Infrastructure Setup

## Defined infrastructure using Terraform.
Configured AKS, Azure VNet, and associated Kubernetes resources.
CI/CD Pipeline

## Implemented using GitHub Actions.
Automates the build, push, and deployment processes.
Security

## Configured network security and Azure Key Vault for managing secrets.
Applied security best practices in Terraform configuration.
How to Run Locally
Clone the Repository

## bash
Copy code
git clone <repository-url>
cd <repository-directory>
Build the Docker Image

## bash
Copy code
docker build -t time-checker-api .
Create a .env File

Create a .env file and specify a port number. Check
.env.example for reference
Copy code
PORT=8000
Run the Docker Container

## bash
Copy code
docker run -e PORT=$(PORT) -p $(PORT):$(PORT) time-checker-api
Example:

## bash
Copy code
docker run -e PORT=8000 -p 8000:8000 time-checker-api
Access the API

## Visit http://localhost:8000/time to access the API.

Deployed API Endpoint
The API is deployed on Azure Kubernetes Service (AKS). You can access the deployed API endpoint via the public IP or DNS name of the AKS service.

GitHub Actions Workflow
