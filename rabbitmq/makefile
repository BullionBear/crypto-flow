# Variables
RABBITMQ_CONTAINER_NAME = rabbitmq
RABBITMQ_IMAGE = rabbitmq:3-management
RABBITMQ_PORT = 5672
RABBITMQ_MANAGEMENT_PORT = 15672
RABBITMQ_USER = cryptostream
RABBITMQ_PASSWORD = bullionbear
VOLUME_NAME = rabbitmq_data

# Check if the volume exists and create it if not
volume-exists:
	@docker volume inspect $(VOLUME_NAME) >/dev/null 2>&1 || \
		(echo "Creating volume $(VOLUME_NAME)" && \
		docker volume create $(VOLUME_NAME))

# Start the RabbitMQ container
start-rabbitmq: volume-exists
	docker run -d --name $(RABBITMQ_CONTAINER_NAME) \
		-p $(RABBITMQ_PORT):5672 \
		-p $(RABBITMQ_MANAGEMENT_PORT):15672 \
		-e RABBITMQ_DEFAULT_USER=$(RABBITMQ_USER) \
		-e RABBITMQ_DEFAULT_PASS=$(RABBITMQ_PASSWORD) \
		-v $(VOLUME_NAME):/var/lib/rabbitmq \
		$(RABBITMQ_IMAGE)

# Stop the RabbitMQ container
stop-rabbitmq:
	docker stop $(RABBITMQ_CONTAINER_NAME)
	docker rm $(RABBITMQ_CONTAINER_NAME)

# Create a volume for persisting data
create-volume:
	docker volume create $(VOLUME_NAME)

# Remove the volume
remove-volume:
	docker volume rm $(VOLUME_NAME)

# View logs
logs:
	docker logs -f $(RABBITMQ_CONTAINER_NAME)

.PHONY: start-rabbitmq stop-rabbitmq create-volume remove-volume logs
