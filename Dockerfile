# 1. Imagem Base
# Utiliza uma imagem oficial do Python. A versão 'slim' é menor e ideal para produção.
FROM python:3.13.4-alpine3.22

# 2. Diretório de Trabalho
# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# 3. Copiar e Instalar Dependências
# Copia o arquivo de dependências primeiro para aproveitar o cache do Docker.
# Se o requirements.txt não mudar, esta camada não será reconstruída.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copiar o Código da Aplicação
# Copia o restante do código da aplicação para o diretório de trabalho. Ex.: ". ." -> Copia todo o diretório
COPY . . 

# 5. Expor a Porta
# Expõe a porta que a aplicação usará.
EXPOSE 8000

# 6. Comando de Execução
# Comando para iniciar a aplicação FastAPI com Uvicorn.
# O host 0.0.0.0 torna a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]