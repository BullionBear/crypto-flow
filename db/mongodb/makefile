# Variables
DB_CONTAINER_NAME = lynkora-mongo
DB_IMAGE = mongo:7.0.5
DB_PORT = 27017
VOLUME_NAME = mongo-data
MONGO_USER = bullionbear
MONGO_PASSWORD = Sunshine4Jellybean

# Check if the volume exists and create it if not
volume-exists:
	@docker volume inspect $(VOLUME_NAME) >/dev/null 2>&1 || \
		(echo "Creating volume $(VOLUME_NAME)" && \
		docker volume create $(VOLUME_NAME))

start-db: volume-exists
	docker run -d --name $(DB_CONTAINER_NAME) \
	-e MONGO_INITDB_ROOT_USERNAME=$(MONGO_USER) \
	-e MONGO_INITDB_ROOT_PASSWORD=$(MONGO_PASSWORD) \
	-v $(VOLUME_NAME):/data/db \
	-p $(DB_PORT):27017 \
	--network lynkora \
	mongo:7.0.5

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
