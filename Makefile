docker-build:
	docker compose up --build -d; \
	docker exec project_php bash -c "composer install"; \

docker-up:
	docker compose up -d ;\

docker-exec:
	docker exec -it project_php bash

run-phpstan:
	docker-compose exec project_php phpstan analyse src
