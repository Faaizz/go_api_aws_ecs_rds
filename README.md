# Go API on AWS ECS
Golang API deployed on Amazon ECS with data persistence on Amazon RDS.


## Development Environment
### Pre-Commit Hooks
Install pre-commit hooks with:
```shell
pre-commit install
```

## Testing
### Generating Mocks
```shell
go generate ./...
```
### Running Tests
To run tests:
```shell
go test -coverprofile=coverage.out ./...
go tool cover -func=coverage.out
```

### Deploy Development Server (Docker)
Deploy deployment server and PosgreSQL DB with `docker-compose`.
```shell 
cd .docker
docker-compose up --build

# Stop the server and database
docker-compose down
```

### Deploy Development Server
You can also deploy a development server without using `docker-compose`. 
However, you must provide a database server to connect to.
```shell
cd src

export BASIC_AUTH_USER="admin"
export BASIC_AUTH_PASSWORD="password"

export DB_USER="admin"
export DB_PASSWORD="password"
export DB_NAME="gorm"
export DB_HOST="localhost"
export DB_PORT="5432"
export DB_SSLMODE="disable"

go run .
```
### Deploy Development Server (Docker)
```shell 
docker build -f .docker/Dockerfile -t go_api_aws_ecs_rds .

docker run --rm -ti -e BASIC_AUTH_USER="admin" -e BASIC_AUTH_PASSWORD="password" -e DB_USER="admin" -e DB_PASSWORD="password" -e DB_NAME="gorm" -e DB_HOST="localhost" -e DB_PORT="5432" -e DB_SSLMODE="disable" go_api_aws_ecs_rds
```
### Client Requests
```shell
export API_URL="http://localhost:8080/api/v1"
export HEALTH_URL="${API_URL}/healthz"
export BOOK_URL="${API_URL}/book"

# Check health
curl -X GET "${HEALTH_URL}"

# List books
curl -X GET "${BOOK_URL}"

# Create book
curl -X POST \
  -u "admin:password" \
  -H "Content-Type: application/json" \
  --data '{"title":"The Power of Geography","author":"Tim Marshall","year":2009}' \
  "${BOOK_URL}"

# Read book
curl -X GET \
  -u "admin:password" \
  "${BOOK_URL}/ID"

# Update book
curl -X PUT \
  -u "admin:password" \
  -H "Content-Type: application/json" \
  --data '{"title":"The Gods are to blame","author":"John Doe","year":1992}' \
  "${BOOK_URL}/ID"

# Delete book
curl -X DELETE \
  -u "admin:password" \
  "${BOOK_URL}/ID"
```
