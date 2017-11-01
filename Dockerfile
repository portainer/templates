FROM nginx:stable-alpine

COPY templates.json /usr/share/nginx/html/templates.json
COPY stack_templates.json /usr/share/nginx/html/stack_templates.json

EXPOSE 80
