# Variables
PROMETHEUS_CONTAINER_NAME = lynkora-prometheus
PROMETHEUS_IMAGE = prom/prometheus:v2.51.0
PROMETHEUS_PORT = 9090
VOLUME_NAME = prometheus-data
CONFIG_FILE = ./prometheus.yml
WEB_CONFIG_FILE = ./web.yml

NGINX_CONFIG = ./nginx.conf
SSL_FULLCHAIN = /etc/letsencrypt/live/prometheus.lynkora.com/fullchain.pem
SSL_PRIVKEY = /etc/letsencrypt/live/prometheus.lynkora.com/privkey.pem


# Check if the volume exists and create it if not
volume-exists-prometheus:
	@docker volume inspect $(VOLUME_NAME) >/dev/null 2>&1 || \
		(echo "Creating volume $(VOLUME_NAME)" && \
		docker volume create $(VOLUME_NAME))

start-prometheus: volume-exists-prometheus
	docker run -d --name $(PROMETHEUS_CONTAINER_NAME) \
	-p $(PROMETHEUS_PORT):9090 \
	-v $(VOLUME_NAME):/prometheus \
	-v $(CONFIG_FILE):/etc/prometheus/prometheus.yml \
	-v $(WEB_CONFIG_FILE):/etc/prometheus/web.yml \
	--network lynkora \
	$(PROMETHEUS_IMAGE) \
	--config.file=/etc/prometheus/prometheus.yml \
	--web.config.file=/etc/prometheus/web.yml

start-reverse-proxy:
	docker run --name proxy-prometheus \
	-v $(SSL_FULLCHAIN):/etc/nginx/ssl/prometheus.lynkora.com.crt \
	-v $(SSL_PRIVKEY):/etc/nginx/ssl/prometheus.lynkora.com.key \
	-v $(NGINX_CONFIG):/etc/nginx/conf.d/default.conf:ro \
	--network lynkora \
	-p 80:80 -p 443:443 -d nginx

stop-reverse-proxy:
	docker stop proxy-prometheus
	docker rm proxy-prometheus

stop-prometheus:
	docker stop $(PROMETHEUS_CONTAINER_NAME)
	docker rm $(PROMETHEUS_CONTAINER_NAME)

create-volume-prometheus:
	docker volume create $(VOLUME_NAME)

remove-volume-prometheus:
	docker volume rm $(VOLUME_NAME)

logs-prometheus:
	docker logs -f $(PROMETHEUS_CONTAINER_NAME)

.PHONY: start-prometheus stop-prometheus create-volume-prometheus remove-volume-prometheus logs-prometheus
