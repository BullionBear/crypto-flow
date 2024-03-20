# Variables
GRAFANA_CONTAINER_NAME = lynkora-grafana
GRAFANA_IMAGE = grafana/grafana:10.0.12-ubuntu
GRAFANA_PORT = 3000
VOLUME_NAME = grafana-data
GRAFANA_ADMIN_USER = bullionbear
GRAFANA_ADMIN_PASSWORD = Sunshine4Jellybean

# Check if the volume exists and create it if not
volume-exists-grafana:
	@docker volume inspect $(VOLUME_NAME) >/dev/null 2>&1 || \
		(echo "Creating volume $(VOLUME_NAME)" && \
		docker volume create $(VOLUME_NAME))

start-grafana: volume-exists-grafana
	docker run -d --name $(GRAFANA_CONTAINER_NAME) \
	-e GF_SECURITY_ADMIN_USER=$(GRAFANA_ADMIN_USER) \
	-e GF_SECURITY_ADMIN_PASSWORD=$(GRAFANA_ADMIN_PASSWORD) \
	-v $(VOLUME_NAME):/var/lib/grafana \
	-p $(GRAFANA_PORT):3000 \
	--network lynkora \
	grafana/grafana:9.1.0

stop-grafana:
	docker stop $(GRAFANA_CONTAINER_NAME)
	docker rm $(GRAFANA_CONTAINER_NAME)

create-volume-grafana:
	docker volume create $(VOLUME_NAME)

remove-volume-grafana:
	docker volume rm $(VOLUME_NAME)

logs-grafana:
	docker logs -f $(GRAFANA_CONTAINER_NAME)

.PHONY: start-grafana stop-grafana create-volume-grafana remove-volume-grafana logs-grafana
