FROM nginx:1.21-alpine

MAINTAINER Dimitris Kagialis (d.kagialis1@westminster.ac.uk)

# Build-time variables specified by docker-compose.yml / .env
ARG SERVICE_URL
ARG SERVICE_DOMAIN
ARG SERVICE_EMAIL

# Define environment variables
ENV SERVICE_URL ${SERVICE_URL}
ENV DOMAIN ${SERVICE_DOMAIN}
ENV EMAIL ${SERVICE_EMAIL}

# Install certbot and openssl
# Using inotifywait to watch our certificates and trigger actions on change
RUN apk add inotify-tools openssl certbot

# Configure website
COPY ssl/ /etc/ssl-options
COPY nginx.conf /etc/nginx/nginx.conf
COPY cert-nginx.conf /etc/nginx/conf.d/default.conf.template
RUN envsubst '${DOMAIN}${SERVICE_URL}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && \
    rm -f /etc/nginx/conf.d/default.conf.template && \
    rm -f /etc/nginx/sites-enabled/default && \
    mkdir -p /var/cache/nginx/proxycache && \
    mkdir -p /var/cache/nginx/proxytemp

WORKDIR /opt
COPY cert-entrypoint.sh entrypoint.sh
COPY cert-request.sh request.sh
COPY health-check.sh status.sh

RUN chmod a+x entrypoint.sh && \
    chmod a+x request.sh && \
    chmod a+x status.sh

EXPOSE 80 443

ENTRYPOINT ["./entrypoint.sh"]
