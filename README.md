
# BeaconSync — Global Solution 2026/2 (DevOps Tools & Cloud Computing)

## Sobre a Equipe e Disciplina

- **Instituição:** FIAP — Faculdade de Informática e Administração Paulista
- **Turma:** 2TSDPX
- **Disciplina:** DevOps Tools & Cloud Computing
- **Professor:** João Menk

### Integrantes do Grupo

- Felipe Ribeiro Salles de Camargo | RM565224
- João Pedro Pereira Camilo | RM562005
- Lucas Matsubara Reis | RM565020
- **Pamella Christiny Chaves Brito | RM565206**

---

## Links de Acesso do Projeto

- **Azure DevOps Organization / Project:** [Acessar Azure DevOps](https://dev.azure.com/RM562005/GS-BeaconSync)
- **Web App em Produção (Swagger):** [https://rm565206-beaconsync-api.azurewebsites.net/swagger](https://rm565206-beaconsync-api.azurewebsites.net/swagger)
- **Vídeo de Demonstração (YouTube):** [Assistir no YouTube](https://www.google.com/search?q=%23) *(inserir link)*

---

## Resumo do Projeto: BeaconSync

O **BeaconSync** é uma solução voltada para situações de emergência em desastres climáticos (como enchentes e alagamentos). Em cenários críticos, pessoas vulneráveis (idosos acamados, pessoas com deficiência, bebês e dependentes de suporte médico) correm sérios riscos, muitas vezes ficando isoladas sem que as equipes de resgate saibam sua localização exata.

A plataforma atua organizando o processo em três etapas fundamentais:

1. **Antes da crise:** Cadastro prévio e unificado de pessoas vulneráveis por familiares e responsáveis, mapeando múltiplos endereços e indicando a localização atual.
2. **Durante a crise:** Emissão de alertas por órgãos competentes, confirmação da situação de risco/segurança por parte dos responsáveis e geração de um **mapa de calor dinâmico dividido por distritos**.
3. **No resgate:** Criação de ocorrências priorizadas e formação de equipes integrando profissionais e voluntários, acompanhando o status do salvamento até a conclusão.

---

## Stack Tecnológica (.NET)

O backend da aplicação foi desenvolvido utilizando o ecossistema **.NET (versão 10)**, estruturado sob os princípios de **Clean Architecture** (separação em camadas: API, Application, Domain, Infrastructure, e Projetos de Testes Unitários e de Integração com xUnit). O uso do .NET garante alta performance, segurança robusta através de autenticação JWT, tratamento de requisições assíncronas e integração nativa com ORMs modernos como o **Entity Framework Core**.

---

## Desenho da Arquitetura Macro

Abaixo está representada a arquitetura macro da solução BeaconSync, ilustrando a integração entre os componentes do sistema, banco de dados e ambiente de nuvem:

![Arquitetura BeaconSync](./Scripts/img-arquitetura/arquitetura%20BeaconSync.png)

---

## ☁️ Infraestrutura Provisionada em Nuvem (Azure CLI)

A infraestrutura do projeto foi totalmente provisionada de forma automatizada via scripts em Azure CLI, dividida em dois Grupos de Recursos estratégicos na região do **Canada Central**:

### 1. Grupo de Recursos do Banco de Dados
- **Nome do Resource Group:** `Beaconsync-Banco-565206`
- **Servidor SQL:** `rm565206-sql-server` (Banco de Dados PaaS - Azure SQL / SQL Server)
- **Banco de Dados:** `rm565206-sqldb`

### 2. Grupo de Recursos da Aplicação (Web App)
- **Nome do Resource Group:** `BeaconSyn-WebApp-565206`
- **Plano de Serviço:** `rm565206-webapp-plan` (App Service Plan)
- **Aplicação Web:** `rm565206-beaconsync-api` (Azure App Service rodando .NET em ambiente Linux)

---

## Estrutura da Pasta `Scripts` (Entregáveis)

O repositório conta com uma pasta centralizada chamada **`Scripts`** que agrupa todos os artefatos técnicos exigidos pelo escopo do projeto:

- `Scripts/img-arquitetura/`: Contém a imagem oficial do diagrama macro de arquitetura da solução (`arquitetura BeaconSync.png`).
- `Scripts/json-teste/`: Armazena payloads e exemplos em formato JSON (`dados_teste_beaconsync.json`) para testes manuais dos endpoints de POST e PUT via Postman ou Swagger.
- `Scripts/Script-CLI-Infraestrutura/`: Contém o script de automação (`deploy-infra.sh`) responsável pelo provisionamento dos recursos e grupos de recursos na Azure via CLI.
- `Scripts/sql-ddl/`: Agrupa os scripts de banco de dados e DDL relacional (`ddl.sql`) utilizados para a estruturação das tabelas e relacionamentos.

---

## ⚙️ Configuração de Variáveis de Ambiente (`appsettings.json`)

Para rodar a aplicação localmente, é necessário configurar as credenciais de acesso ao banco de dados e a chave de criptografia do token JWT. 

O arquivo de configuração original localiza-se em:  
`BeaconSync.API/appsettings.json`

### Template do `appsettings.json` (Sem credenciais sensíveis)
Para fins de versionamento seguro e boas práticas, o repositório utiliza o seguinte modelo estrutural. Preencha os campos de `ConnectionStrings` e `JwtSettings` com as suas credenciais locais ou de produção para executar o projeto:

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "AllowedHosts": "*",
  "ConnectionStrings": {
    "DefaultConnection": "Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=SEU_HOST_ORACLE)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=ORCL)));User Id=SEU_USUARIO;Password=SUA_SENHA;"
  },
  "JwtSettings": {
    "Key": "SUA_CHAVE_SECRETA_JWT_SUPER_SEGURA_COM_NO_MINIMO_32_CARACTERES"
  }
}

```

---

## Atendimento aos Requisitos da Global Solution

O projeto cumpre rigorosamente todas as exigências estabelecidas no escopo da disciplina:

* **Provisionamento via Azure CLI:** Recursos em nuvem criados por script e utilizados pelo pipeline de CI/CD.
* **Azure DevOps Integrado:** Repositório privado no Azure Repos, gerenciamento de tarefas no Azure Boards e automação via Azure Pipelines (YAML).
* **Governança de Branch (Main Protegida):**
* Exigência de revisor obrigatório com permissão configurada para auto-aprovação simulada.
* Obrigatoriedade de vincular *Work Items* do Azure Boards aos Pull Requests.
* Validação de build (*Build Validation*) ativada de forma que a branch principal só recebe alterações após PRs validados e testados.


* **Testes Automáticos no CI:** Execução automática de testes unitários e de integração (xUnit) a cada ciclo de compilação.
* **Organização dos Scripts:** Centralizados estruturadamente na pasta `/Scripts` (incluindo DDL, automações CLI, imagens de arquitetura e arquivos de teste).
* **Documentação de API:** Utilização nativa do **Swagger UI**, com os jsons manuais de teste disponíveis na pasta `/Scripts/json-teste/` para validação de endpoints, e abaixo:

---

## Exemplos de Contratos CRUD (Payloads JSON)

Abaixo estão detalhados os exemplos de JSONs utilizados para as operações de cadastro (`POST`) e atualização (`PUT`) de todas as entidades expostas pela API do **BeaconSync**.

### 1. Voluntários (`/api/voluntarios`)

* **POST (Criar Voluntário):**

```json
{
  "nome": "Pamella Christiny Chaves Brito",
  "email": "pamella.christinyy2006@gmail.com",
  "telefone": "11988887777"
}

```

* **PUT (Atualizar Voluntário):**

```json
{
  "id": 1,
  "nome": "Pamella Christiny Chaves Brito",
  "email": "pamella.atualizado@beaconsync.com",
  "telefone": "11999998888"
}

```

---

### 2. Pessoas Vulneráveis (`/api/pessoavulneravel`)

* **POST (Cadastrar Pessoa Vulnerável):**

```json
{
  "nome": "João da Silva",
  "idade": 45,
  "tipoVulnerabilidade": "Insegurança Alimentar e Habitacional",
  "necessidadeEspecial": "Mobilidade reduzida",
  "enderecoId": 1
}

```

* **PUT (Atualizar Pessoa Vulnerável):**

```json
{
  "id": 1,
  "nome": "João da Silva",
  "idade": 45,
  "tipoVulnerabilidade": "Insegurança Alimentar",
  "necessidadeEspecial": "Uso de cadeira de rodas",
  "enderecoId": 1
}

```

---

### 3. Endereços (`/api/endereco`)

* **POST (Cadastrar Endereço):**

```json
{
  "logradouro": "Rua Pacobaiba, 100 - Sacomã",
  "cep": "03285-000",
  "cidade": "São Paulo",
  "estado": "SP"
}

```

* **PUT (Atualizar Endereço):**

```json
{
  "id": 1,
  "logradouro": "Rua Pacobaiba, 150 - Sacomã",
  "cep": "03285-000",
  "cidade": "São Paulo",
  "estado": "SP"
}

```

---

### 4. Responsáveis (`/api/responsavel`)

* **POST (Cadastrar Responsável):**

```json
{
  "nome": "Maria Oliveira",
  "telefone": "11977776666",
  "email": "maria.responsavel@beaconsync.com"
}

```

* **PUT (Atualizar Responsável):**

```json
{
  "id": 1,
  "nome": "Maria Oliveira dos Santos",
  "telefone": "11977776666",
  "email": "maria.santos@beaconsync.com"
}

```

---

### 5. Respostas a Alertas (`/api/respostaalerta`)

* **POST (Registrar Resposta a Alerta):**

```json
{
  "descricao": "Encaminhado kit de alimentos e agasalhos para a família na comunidade.",
  "status": "Em Andamento",
  "voluntarioId": 1,
  "pessoaVulneravelId": 1
}

```

* **PUT (Atualizar Resposta a Alerta):**

```json
{
  "id": 1,
  "descricao": "Atendimento concluído com sucesso e suporte prestado.",
  "status": "Resolvido",
  "voluntarioId": 1,
  "pessoaVulneravelId": 1
}

```