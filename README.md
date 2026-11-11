# BeaconSync — Global Solution 2026/2 (DevOps Tools & Cloud Computing)

## 📌 Sobre a Equipe e Disciplina

* **Instituição:** FIAP — Faculdade de Informática e Administração Paulista
* **Turma:** 2TSDPX
* **Disciplina:** DevOps Tools & Cloud Computing
* **Professor:** João Menk

### Integrantes do Grupo

* Felipe Ribeiro Salles de Camargo | RM565224
* João Pedro Pereira Camilo | RM562005
* Lucas Matsubara Reis | RM565020
* **Pamella Christiny Chaves Brito | RM565206**

---

## 🔗 Links de Acesso do Projeto

* **Azure DevOps Organization / Project:** [Acessar Azure DevOps](https://www.google.com/search?q=%23) *(inserir link)*
* **Web App em Produção (Swagger):** [https://rm565206-beaconsync-api.azurewebsites.net/swagger](https://www.google.com/search?q=https://rm565206-beaconsync-api.azurewebsites.net/swagger)
* **Vídeo de Demonstração (YouTube):** [Assistir no YouTube](https://www.google.com/search?q=%23) *(inserir link)*

---

## 🚀 Resumo do Projeto: BeaconSync

O **BeaconSync** é uma solução voltada para situações de emergência em desastres climáticos (como enchentes e alagamentos). Em cenários críticos, pessoas vulneráveis (idosos acamados, pessoas com deficiência, bebês e dependentes de suporte médico) correm sérios riscos, muitas vezes ficando isoladas sem que as equipes de resgate saibam sua localização exata.

A plataforma atua organizando o processo em três etapas fundamentais:

1. **Antes da crise:** Cadastro prévio e unificado de pessoas vulneráveis por familiares e responsáveis, mapeando múltiplos endereços e indicando a localização atual.
2. **Durante a crise:** Emissão de alertas por órgãos competentes, confirmação da situação de risco/segurança por parte dos responsáveis e geração de um **mapa de calor dinâmico dividido por distritos**.
3. **No resgate:** Criação de ocorrências priorizadas e formação de equipes integrando profissionais e voluntários, acompanhando o status do salvamento até a conclusão.

---

## 💻 Stack Tecnológica (.NET)

O backend da aplicação foi desenvolvido utilizando o ecossistema **.NET (versão 10)**, estruturado sob os princípios de **Clean Architecture** (separação em camadas: API, Application, Domain, Infrastructure, e Projetos de Testes Unitários e de Integração com xUnit). O uso do .NET garante alta performance, segurança robusta através de autenticação JWT, tratamento de requisições assíncronas e integração nativa com ORMs modernos como o **Entity Framework Core**.

---

## 🏗️ Desenho da Arquitetura Macro

> *(Adicione aqui a imagem ou o fluxograma da arquitetura macro do projeto)*

---

## ☁️ Infraestrutura Provisionada em Nuvem (Azure CLI)

A infraestrutura do projeto foi totalmente provisionada de forma automatizada via scripts em Azure CLI, dividida em dois Grupos de Recursos estratégicos na região do **Canada Central**:

### 1. Grupo de Recursos do Banco de Dados

* **Nome do Resource Group:** `Beaconsync-Banco-565206`
* **Servidor SQL:** `rm565206-sql-server` (Banco de Dados PaaS - Azure SQL / SQL Server)
* **Banco de Dados:** `rm565206-sqldb`

### 2. Grupo de Recursos da Aplicação (Web App)

* **Nome do Resource Group:** `BeaconSyn-WebApp-565206`
* **Plano de Serviço:** `rm565206-webapp-plan` (App Service Plan)
* **Aplicação Web:** `rm565206-beaconsync-api` (Azure App Service rodando .NET em ambiente Linux)

---

## 📋 Atendimento aos Requisitos da Global Solution

O projeto cumpre rigorosamente todas as exigências estabelecidas no escopo da disciplina:

* **Provisionamento via Azure CLI:** Recursos em nuvem criados por script e utilizados pelo pipeline de CI/CD.
* **Azure DevOps Integrado:** Repositório privado no Azure Repos, gerenciamento de tarefas no Azure Boards e automação via Azure Pipelines (YAML).
* **Governança de Branch (Main Protegida):**
* Exigência de revisor obrigatório com permissão configurada para auto-aprovação simulada.
* Obrigatoriedade de vincular *Work Items* do Azure Boards aos Pull Requests.
* Validação de build (*Build Validation*) ativada de forma que a branch principal só recebe alterações após PRs validados e testados.


* **Testes Automáticos no CI:** Execução automática de testes unitários e de integração (xUnit) a cada ciclo de compilação.
* **Organização dos Scripts:**
* Arquivos de DDL e scripts de banco localizados em `/scripts/script-bd.sql`.
* Scripts de automação Azure CLI localizados na pasta `/scripts`.
* Arquivo de pipeline YAML (`azure-pipelines.yml`) posicionado na raiz do repositório.


* **Documentação de API:** Utilização nativa do **Swagger UI**, dispensando arquivos JSON manuais no README.