#!/bin/bash

# Configurações do container
DB_USER="admin"
DB_ROOT_PASSWORD="admin"
DB_PASSWORD="admin"
DB_NAME="alurafood_pagamento"
PORT="3306"

# Remove o container se já existir
docker rm -f mysql_medvoll 2>/dev/null || true

# Inicia o container MySQL (CORREÇÃO: removido o espaço após o =)
docker run --name mysql_alurafood_pagamento \
  -e MYSQL_ROOT_PASSWORD=$DB_ROOT_PASSWORD \
  -e MYSQL_DATABASE=$DB_NAME \
  -e MYSQL_USER=$DB_USER \
  -e MYSQL_PASSWORD=$DB_PASSWORD \
  -p $PORT:3306 \
  -d mysql:latest

echo "Aguardando o MySQL iniciar (15-30 segundos)..."
sleep 25  # MySQL geralmente precisa de mais tempo para inicializar

echo "Verificando conexão com o banco de dados..."
# Comando correto para testar conexão no MySQL
docker exec -i mysql_medvoll mysql -u$DB_USER -p$DB_PASSWORD -e "SHOW DATABASES;" $DB_NAME

echo "Banco MySQL pronto para uso."