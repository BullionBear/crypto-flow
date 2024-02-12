# Variables
DB_CONTAINER_NAME = timescaledb
DB_IMAGE = timescale/timescaledb:latest-pg12
DB_PORT = 5432
VOLUME_NAME = timescaledb-data
POSTGRES_DB = cryptostream
POSTGRES_USER = bullionbear
POSTGRES_PASSWORD = Sunshine4Jellybean

# Check if the volume exists and create it if not
volume-exists:
	@docker volume inspect $(VOLUME_NAME) >/dev/null 2>&1 || \
		(echo "Creating volume $(VOLUME_NAME)" && \
		docker volume create $(VOLUME_NAME))

# Start the TimescaleDB container
start-db: volume-exists
	docker run -d --name $(DB_CONTAINER_NAME) \
		-p $(DB_PORT):5432 \
		-e POSTGRES_DB=$(POSTGRES_DB) \
		-e POSTGRES_USER=$(POSTGRES_USER) \
		-e POSTGRES_PASSWORD=$(POSTGRES_PASSWORD) \
		-v `pwd`/schema:/docker-entrypoint-initdb.d \
		-v $(VOLUME_NAME):/var/lib/postgresql/data \
		$(DB_IMAGE)

# Stop the TimescaleDB container
stop-db:
	docker stop $(DB_CONTAINER_NAME)
	docker rm $(DB_CONTAINER_NAME)

# Create a volume for persisting data
create-volume:
	docker volume create $(VOLUME_NAME)

# Remove the volume
remove-volume:
	docker volume rm $(VOLUME_NAME)

# View logs
logs:
	docker logs -f $(DB_CONTAINER_NAME)

.PHONY: start-db stop-db create-volume remove-volume logs