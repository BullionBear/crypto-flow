# Variables
DB_CONTAINER_NAME = lynkora-postgres
DB_IMAGE = postgres:16.2
DB_PORT = 5432
VOLUME_NAME = postgres-data
POSTGRES_USER = bullionbear
POSTGRES_PASSWORD = Sunshine4Jellybean
POSTGRES_DB = lynkoraDB

# Check if the volume exists and create it if not
volume-exists:
	@docker volume inspect $(VOLUME_NAME) >/dev/null 2>&1 || \
		(echo "Creating volume $(VOLUME_NAME)" && \
		docker volume create $(VOLUME_NAME))

start-db: volume-exists
	docker run -d --name $(DB_CONTAINER_NAME) \
	-e POSTGRES_USER=$(POSTGRES_USER) \
	-e POSTGRES_PASSWORD=$(POSTGRES_PASSWORD) \
	-e POSTGRES_DB=$(POSTGRES_DB) \
	-v $(VOLUME_NAME):/var/lib/postgresql/data \
	-p $(DB_PORT):5432 \
	--network lynkora \
	--memory 8g \
	--cpus 4 \
	$(DB_IMAGE)

stop-db:
	docker stop $(DB_CONTAINER_NAME)
	docker rm $(DB_CONTAINER_NAME)

create-volume:
	docker volume create $(VOLUME_NAME)

remove-volume:
	docker volume rm $(VOLUME_NAME)

logs:
	docker logs -f $(DB_CONTAINER_NAME)

.PHONY: start-db stop-db create-volume remove-volume logs
