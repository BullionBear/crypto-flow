# Variables
DB_CONTAINER_NAME = mongodb
DB_IMAGE = mongo:7.0.5
DB_PORT = 27017

# Check if the volume exists and create it if not
volume-exists:
	@docker volume inspect $(VOLUME_NAME) >/dev/null 2>&1 || \
		(echo "Creating volume $(VOLUME_NAME)" && \
		docker volume create $(VOLUME_NAME))
