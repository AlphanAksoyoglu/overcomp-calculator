# FROM node:16-alpine

# WORKDIR '/app'

# COPY ./package.json ./

# RUN npm install

# COPY . .

# CMD ["npm","run","start"]


FROM node:16-alpine as builder

WORKDIR '/app'

COPY ./package.json ./

RUN npm install

COPY . .

RUN npm run build

#built react will be in /app/build
# we copy this over to /usr/share/nginx/html folder
FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/dfault.conf
COPY --from=builder /app/build /usr/share/nginx/html
