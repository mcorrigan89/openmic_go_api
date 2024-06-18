start:
	./bin/main

build:
	go build -o=./bin/main ./cmd

test:
	go test -v ./...
	
codegen:
	go run github.com/99designs/gqlgen

# https://github.com/golang-migrate/migrate

models:
	pg_dump --schema-only go_api_seed > schema.sql
	sqlc generate

migrate-create:
	migrate create -ext sql -dir migrations -seq $(name)

migrate-up:
	migrate -path=./migrations -database="postgres://admin:admin@localhost:5432/go_api_seed?sslmode=disable" up

migrate-down:
	migrate -path=./migrations -database="postgres://admin:admin@localhost:5432/go_api_seed?sslmode=disable" down 1
