# Usa imagem leve do Node.js baseada em Alpine
FROM node:18-alpine

# Define diretório de trabalho
WORKDIR /app

# Copia arquivos de dependência da aplicação
COPY app/package*.json ./
RUN npm install

# Copia o restante da aplicação
COPY app/ .

# Expõe a porta usada pela aplicação
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["npm", "start"]
