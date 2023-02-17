FROM node:gallium-alpine3.16 AS builder
WORKDIR /app

COPY package.json package.json
COPY tsconfig.json tsconfig.json
RUN npm install --omit=dev
COPY src ./src
COPY public ./public
COPY astro.config.mjs astro.config.mjs
RUN npm run build

FROM httpd:2.4 as runtime
COPY --from=build /app/dist /usr/local/apache2/htdocs/
EXPOSE 80
