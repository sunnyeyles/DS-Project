FROM node:alpine3.20

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install --no-cache

COPY . .

RUN npm run build

EXPOSE 8080

CMD ["npm", "run", "build"]



