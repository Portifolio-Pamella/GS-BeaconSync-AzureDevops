#!/bin/bash

# ==============================================================================
# SCRIPT DE PROVISIONAMENTO EM NUVEM - GLOBAL SOLUTION (FIAP)
# Aluna: Pamella Christiny Chaves Brito | RM: 565206
# Objetivo: Criar e isolar a infraestrutura em nuvem usando Azure CLI,
#           separando o Web App (camadas) e o Banco de Dados em Resource Groups distintos.
# ==============================================================================

# Interrompe a execução caso ocorra algum erro crítico
set -e

# ==========================================
# 1. VARIÁVEIS DE CONFIGURAÇÃO (Padrão RM 565206)
# ==========================================
RM="565206"
LOCATION="canadacentral"

# Requisito atendido: Grupos de recursos separados para cada contexto (App e Banco)
RG_WEBAPP="BeaconSyn-WebApp-$RM"
RG_DB="Beaconsync-Banco-$RM"

echo "=================================================================="
echo " INICIANDO PROVISIONAMENTO EM NUVEM PARA O RM: $RM"
echo " Região Alvo: $LOCATION"
echo "=================================================================="

# ==========================================
# 2. CRIAÇÃO DOS GRUPOS DE RECURSOS ISOLADOS
# ==========================================
echo -e "\n[Passo 1/3] Criando os Grupos de Recursos segregados..."

# Grupo exclusivo para hospedar a API (.NET) e seu plano de serviço
az group create --name "$RG_WEBAPP" --location "$LOCATION"
echo "-> Grupo de Recursos do Web App criado: $RG_WEBAPP"

# Grupo exclusivo para hospedar o Servidor e o Banco de Dados PaaS
az group create --name "$RG_DB" --location "$LOCATION"
echo "-> Grupo de Recursos do Banco de Dados criado: $RG_DB"


# ==========================================
# 3. PROVISIONAMENTO DO BANCO DE DADOS (Azure SQL PaaS)
# ==========================================
echo -e "\n[Passo 2/3] Provisionando o Banco de Dados na Nuvem..."
DB_SERVER="rm$RM-sql-server"
DB_NAME="rm$RM-sqldb"
ADMIN_USER="admin$RM"
ADMIN_PASS="P@ssw0rd2026!"

# Cria o Servidor Gerenciado do Azure SQL dentro do grupo de banco
echo "-> Criando o Servidor SQL ($DB_SERVER)..."
az sql server create \
  --name "$DB_SERVER" \
  --resource-group "$RG_DB" \
  --location "$LOCATION" \
  --admin-user "$ADMIN_USER" \
  --admin-password "$ADMIN_PASS" \
  2>/dev/null || echo "-> O Servidor SQL já existe, prosseguindo..."

# Cria o Banco de Dados relacional na camada Basic (otimizada para custos/testes)
echo "-> Criando o Banco de Dados Relacional ($DB_NAME)..."
az sql db create \
  --resource-group "$RG_DB" \
  --server "$DB_SERVER" \
  --name "$DB_NAME" \
  --edition Basic \
  --service-objective Basic

# Libera a regra de firewall para permitir requisições vindas dos serviços do Azure e da API
echo "-> Configurando o Firewall do Banco (Liberando conexões seguras)..."
az sql server firewall-rule create \
  --resource-group "$RG_DB" \
  --server "$DB_SERVER" \
  --name "AllowAllAzureIPs" \
  --start-ip-address "0.0.0.0" \
  --end-ip-address "0.0.0.0" \
  2>/dev/null || echo "-> Regra de firewall já existente."


# ==========================================
# 4. PROVISIONAMENTO DA APLICAÇÃO WEB (.NET Web App)
# ==========================================
echo -e "\n[Passo 3/3] Provisionando a Infraestrutura do Web App..."
APP_SERVICE_PLAN="rm$RM-webapp-plan"
WEB_APP_NAME="rm$RM-beaconsync-api"

# Cria o Plano de Serviço do App Service em ambiente Linux (Camada Free F1)
echo "-> Criando o App Service Plan Linux ($APP_SERVICE_PLAN)..."
az appservice plan create \
  --name "$APP_SERVICE_PLAN" \
  --resource-group "$RG_WEBAPP" \
  --location "$LOCATION" \
  --sku F1 \
  --is-linux

# Cria o Web App propriamente dito, associando o runtime do .NET para hospedar a API
echo "-> Criando o Web App da API ($WEB_APP_NAME)..."
az webapp create \
  --name "$WEB_APP_NAME" \
  --resource-group "$RG_WEBAPP" \
  --plan "$APP_SERVICE_PLAN" \
  --runtime "DOTNETCORE|10.0"

echo "=================================================================="
echo " PROVISIONAMENTO CONCLUÍDO COM 100% DE SUCESSO!"
echo " Todos os recursos foram alocados e separados por responsabilidade."
echo "=================================================================="