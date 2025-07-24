# 🚀 Projeto DevOps Vitrine

![CI/CD](https://github.com/Ary-Leal/devops-vitrine/actions/workflows/ci-cd.yml/badge.svg)

Este projeto demonstra um pipeline completo de DevOps com CI/CD, infraestrutura como código e monitoramento. A aplicação é uma API simples em Node.js que expõe uma rota `/health` e uma rota `/metrics`.

---

## 🧰 Tecnologias Utilizadas

- Node.js + Express
- Docker (Alpine)
- GitHub Actions
- Terraform + AWS
- Prometheus + Grafana

---

## 📁 Estrutura do Projeto

devops-vitrine/
├── app/                      # Código da aplicação Node.js
│   ├── server.js
│   └── package.json
├── docker/                  # Dockerfile para empacotar a aplicação
│   └── Dockerfile
├── terraform/               # Infraestrutura como código (AWS)
│   ├── main.tf
│   └── variables.tf
├── monitoring/              # Monitoramento com Prometheus e Grafana
│   ├── prometheus.yml
│   ├── grafana-dashboard.json
│   └── docker-compose.yml
├── .github/
│   └── workflows/
│       └── ci-cd.yml
├── .gitignore
└── README.md


---

## 🔄 Fluxo de Funcionamento do Projeto

### 1️⃣ Rodar a aplicação localmente (sem Docker)
```bash
cd app
npm install
npm start

2️⃣ Rodar com Docker (usando Dockerfile em /docker)
bash
docker build -t devops-api -f docker/Dockerfile .
docker run -p 3000:3000 devops-api
3️⃣ Rodar monitoramento com Prometheus + Grafana
bash
cd monitoring
docker-compose up
Prometheus: http://localhost:9090

Grafana: http://localhost:3001

Login padrão: admin / admin

4️⃣ Provisionar infraestrutura com Terraform (AWS)
bash
cd terraform
terraform init
terraform apply
5️⃣ CI/CD com GitHub Actions
O pipeline é disparado automaticamente a cada push na branch main

Etapas:

Instala dependências

Build da imagem Docker

Teste da rota /health

Deploy via SSH para instância EC2

📊 Dashboard de Monitoramento
O Grafana exibe métricas como:

Status da API (up)

Total de requisições (http_requests_total)

Importe o dashboard usando o arquivo grafana-dashboard.json.

👤 Autor
Aryostto Leal 🔗 LinkedIn 🔗 GitHub

📌 Licença
Este projeto está sob a licença MIT.
