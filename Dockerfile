FROM nginx:stable-alpine

COPY templates.json /usr/share/nginx/html/templates.json
COPY logos /usr/share/nginx/html/logos

EXPOSE 80
