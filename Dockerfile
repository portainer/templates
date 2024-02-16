FROM nginx:alpine-slim

COPY templates.json /usr/share/nginx/html/templates.json

EXPOSE 80
