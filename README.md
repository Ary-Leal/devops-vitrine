🚀 devops-vitrine: Uma Jornada Completa em DevOps & SRE
Este repositório é uma vitrine de habilidades em DevOps e Site Reliability Engineering (SRE), demonstrando a construção e operação de uma aplicação contêinerizada através de um pipeline CI/CD completo, automação de infraestrutura, e práticas de entrega contínua (GitOps).

✨ Visão Geral do Projeto
O devops-vitrine exemplifica como modernizar o ciclo de vida de desenvolvimento e operação de uma aplicação, focando em automação, escalabilidade, resiliência e observabilidade. Ele serve como um playbook prático para a implementação de arquiteturas modernas baseadas em contêineres e nuvem.

Tecnologias Utilizadas
Este projeto explora um conjunto de ferramentas e tecnologias essenciais para o universo DevOps:

Kubernetes (K8s): Orquestração de contêineres para deploy, escalabilidade e gerenciamento da aplicação.

Terraform: Infraestrutura como Código (IaC) para provisionamento automatizado de recursos de nuvem (futuramente).

Docker: Contêinerização da aplicação, garantindo portabilidade e isolamento.

GitHub Actions: Pipeline de Integração Contínua (CI) para build e push de imagens Docker.

Argo CD: Ferramenta de Entrega Contínua (CD) com abordagem GitOps, automatizando deploys no Kubernetes a partir de um repositório Git.

Python / Shell Script: Linguagens para automação de tarefas e scripts auxiliares.

Axway API Management (Conceitual): Abordagem para gerenciamento e segurança de APIs.

Azure / OCI (Conceitual): Provedores de nuvem pública para futuras implementações de infraestrutura gerenciada.

🗺️ Arquitetura Proposta
A arquitetura do projeto segue uma abordagem moderna de microsserviços e GitOps:

Desenvolvimento: O código-fonte da aplicação (representada aqui) é versionado no GitHub.

Integração Contínua (CI): Ao realizar um push para o repositório, o GitHub Actions é acionado para:

Executar testes (futuramente).

Construir a imagem Docker da aplicação.

Realizar varredura de segurança na imagem (futuramente).

Publicar a imagem em um Container Registry (ex: Docker Hub, ACR, GCR).

Deploy Contínuo (CD - GitOps):

Os manifestos Kubernetes da aplicação são armazenados em um repositório Git separado (ou em uma pasta dedicada neste mesmo repositório).

Argo CD monitora este repositório de manifestos.

Qualquer alteração nos manifestos (por exemplo, uma nova versão da imagem Docker) é automaticamente sincronizada e aplicada ao cluster Kubernetes pelo Argo CD.

Cluster Kubernetes: Hospeda a aplicação contêinerizada, gerenciando seus pods, serviços e deploys.

Observabilidade (Futuramente): Ferramentas como Prometheus, Grafana e ELK Stack serão integradas para monitorar a saúde, performance e logs da aplicação e do cluster.

Snippet de código

graph TD
    A[Código-Fonte Aplicação] --> B(Git Push)
    B --> C{GitHub Actions}
    C --> D[Construir Imagem Docker]
    D --> E[Publicar Imagem no Registry]
    E --> F[Atualizar Manifestos K8s no Git]
    F --> G[Repositório de Manifestos K8s]
    G --> H{Argo CD}
    H --> I[Deploy/Sincronização no Kubernetes]
    I --> J[Cluster Kubernetes]
    J --> K[Aplicação Rodando]

    subgraph CI/CD Pipeline
        C -- Testes --> D
        D -- Varredura Segurança --> E
    end

    subgraph GitOps
        F <--> H
    end

    subgraph Observabilidade (Futuro)
        J --> L[Prometheus/Grafana]
        J --> M[ELK Stack/Logging]
    end
🚀 Como Rodar o Projeto (Getting Started)
Para colocar este projeto em execução em seu ambiente, siga os passos abaixo. Este guia assume que você já tem um cluster Kubernetes disponível (local ou na nuvem).

Pré-requisitos
Docker: Instalado e configurado.

kubectl: Ferramenta de linha de comando para interagir com clusters Kubernetes.

Helm (Opcional, mas Recomendado): Para instalação simplificada de Argo CD e outras ferramentas.

Um Cluster Kubernetes:

Local: Minikube, Kind, Docker Desktop com K8s habilitado.

Nuvem: AKS (Azure Kubernetes Service), GKE (Google Kubernetes Engine), EKS (Amazon Elastic Kubernetes Service), OKE (Oracle Container Engine for Kubernetes).

1. Clonar o Repositório
Bash

git clone https://github.com/Ary-Leal/devops-vitrine.git
cd devops-vitrine
2. Contêinerizar a Aplicação (Build da Imagem)
A aplicação de exemplo é simples, mas você pode construir sua própria imagem Docker.

Bash

docker build -t aryostto/devops-vitrine:latest .
3. Publicar a Imagem (Opcional, mas Recomendado)
Para que seu cluster Kubernetes possa puxar a imagem, é recomendável publicá-la em um registry público ou privado.

Bash

docker push aryostto/devops-vitrine:latest
Nota: Se estiver usando um registry privado, certifique-se de configurar as credenciais apropriadas no seu cluster Kubernetes (ImagePullSecrets).

4. Instalar o Argo CD no seu Cluster Kubernetes
Vamos usar Helm para uma instalação rápida e fácil do Argo CD.

Bash

# Adicionar o repositório Helm do Argo CD
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update

# Criar um namespace para o Argo CD
kubectl create namespace argocd

# Instalar o Argo CD
helm install argocd argo/argo-cd -n argocd

# Obter a senha inicial do admin do Argo CD
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo

# Expor o servidor de API do Argo CD (via port-forwarding para acesso local)
kubectl port-forward svc/argocd-server -n argocd 8080:443
Acesse o Argo CD em https://localhost:8080 e faça login com admin e a senha obtida.

5. Configurar o Argo CD para Deploy da Aplicação
O Argo CD irá monitorar os manifestos Kubernetes na pasta k8s deste repositório.

No UI do Argo CD, clique em + NEW APP.

Preencha os detalhes:

Application Name: devops-vitrine-app

Project: default

Sync Policy: Automatic (com Prune e Self Heal habilitados)

Repository URL: https://github.com/Ary-Leal/devops-vitrine.git

Revision: HEAD

Path: k8s (ou a pasta onde seus manifestos estão)

Cluster: in-cluster (ou o nome do seu cluster remoto, se aplicável)

Namespace: default (ou o namespace desejado para a aplicação)

Clique em CREATE. O Argo CD começará a sincronizar e implantar a aplicação.

6. Acessar a Aplicação
Uma vez que a aplicação esteja sincronizada e os pods estejam rodando no Kubernetes, você pode acessá-la:

Bash

kubectl get svc
# Encontre o Service da sua aplicação (ex: devops-vitrine-service)
# Se for um LoadBalancer, obterá um IP externo. Se for ClusterIP, pode usar port-forward.
kubectl port-forward svc/<nome-do-seu-service> 8081:80
Agora você pode acessar a aplicação em http://localhost:8081.

🛠️ Próximas Features e Melhorias (Roadmap)
Este projeto é uma base sólida e será continuamente aprimorado com as seguintes funcionalidades, servindo como um guia para futuras contribuições:

Infraestrutura como Código (IaC)
Implementação de Terraform:

Adicionar scripts Terraform para provisionar um cluster Kubernetes (AKS, GKE ou OCI OKE).

Configurar rede, grupos de segurança e outras dependências de infraestrutura via Terraform.

Automatizar o deploy do Argo CD usando Terraform e Helm Provider.

Observabilidade e Monitoramento
Integração com Prometheus & Grafana:

Deploy de um stack Prometheus para coleta de métricas do cluster e da aplicação.

Configuração de dashboards Grafana para visualização de performance e saúde.

Logging Centralizado com ELK Stack:

Implementação de Fluent Bit/Filebeat para coletar logs dos pods.

Envio de logs para Elasticsearch e visualização no Kibana.

Health Checks Robustos:

Garantir livenessProbe e readinessProbe configurados para todos os Deployments.

Configuração de Horizontal Pod Autoscaler (HPA) para escalabilidade automática da aplicação com base em CPU/Memória.

Testes e Qualidade de Código
Testes Automatizados:

Adicionar testes unitários, de integração e/ou e2e à aplicação (se aplicável).

Integrar a execução dos testes no pipeline do GitHub Actions.

Análise de Qualidade de Código:

Adicionar linters e ferramentas de análise estática de código no pipeline CI.

Segurança
Varredura de Vulnerabilidades:

Integrar ferramentas como Trivy ou Snyk no GitHub Actions para varredura de imagens Docker em busca de vulnerabilidades.

Políticas de Rede (Network Policies):

Exemplos de NetworkPolicies no Kubernetes para controlar o tráfego entre pods.

Gerenciamento de Segredos (Secrets Management):

Demonstrar o uso de Kubernetes Secrets de forma segura, ou integração com Azure Key Vault / OCI Vault se a infra for na nuvem.

Implementação de RBAC:

Definição de roles e rolebindings para controle de acesso granular no cluster.

🤝 Como Contribuir
Contribuições são sempre bem-vindas! Se você tiver ideias para novas funcionalidades, melhorias, ou encontrou algum bug, sinta-se à vontade para abrir uma issue ou enviar um pull request.

Faça um fork do projeto.

Crie uma nova branch (git checkout -b feature/nova-feature).

Faça suas alterações e adicione commits claros.

Envie suas alterações (git push origin feature/nova-feature).

Abra um Pull Request, descrevendo suas mudanças.

👤 Autor
Aryostto Leal 🔗 LinkedIn 🔗 GitHub

📌 Licença
Este projeto está sob a licença MIT.
