FROM alpine:3.18 AS builder

COPY containers /containers
COPY stacks /stacks
COPY build.sh /build.sh

RUN apk add --no-cache bash jq && \
    /build.sh && \
    /build.sh 1.20.0 && \
    /build.sh 2.0

FROM nginx:stable-alpine as image

COPY --from=builder templates.json /usr/share/nginx/html/templates.json
COPY --from=builder templates-1.20.0.json /usr/share/nginx/html/templates-1.20.0.json
COPY --from=builder templates-2.0.json /usr/share/nginx/html/templates-2.0.json

EXPOSE 80
