# 🚀 Projeto DevOps Vitrine

Este projeto demonstra um pipeline completo de DevOps com CI/CD, infraestrutura como código e monitoramento.

## Tecnologias
- Node.js + Express
- Docker
- GitHub Actions
- Terraform + AWS
- Prometheus + Grafana

## Funcionalidades
- Deploy automático via CI/CD
- Infraestrutura provisionada com Terraform
- Monitoramento com Prometheus e Grafana

## Como executar localmente
```bash
# Rodar aplicação
cd app
npm install
npm start

# Rodar com Docker
docker build -t devops-api .
docker run -p 3000:3000 devops-api

# Rodar monitoramento
cd monitoring
docker-compose up
