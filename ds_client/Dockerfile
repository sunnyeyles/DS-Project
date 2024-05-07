FROM node:latest

COPY package.json ./

COPY package-lock.json* ./

RUN npm i

COPY . .

CMD ["npm", "run", "dev"]


