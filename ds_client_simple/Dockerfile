FROM node:alpine3.20

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install --no-cache

COPY . .

EXPOSE 8080

CMD ["npm", "run", "build"]