FROM node:18-alpine

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 8080

CMD [ "npm", "run", "build" ]
# File ./Dockerfile
# FROM node:alpine AS build

# WORKDIR /app

# COPY package.json ./

# RUN npm install

# ENV PATH /app/node_modules/.bin:$PATH

# COPY . .

# RUN npm run build

# FROM nginx:alpine

# COPY ./nginx.conf /etc/nginx/conf.d/default.conf
# COPY --from=build /app/dist /var/www/html/

# EXPOSE 8080

# ENTRYPOINT ["nginx","-g","daemon off;"]