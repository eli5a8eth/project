docker-build:
	docker compose up --build -d; \
	docker exec php bash -c "composer install"; \

docker-up:
	docker compose up -d ;\

docker-exec:
	docker exec php bash

run-phpstan:
	docker-compose exec php phpstan analyse src
