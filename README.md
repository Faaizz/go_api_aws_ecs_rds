# Go API on AWS ECS
Golang API deployed on Amazon ECS with data persistence on Amazon RDS.


## Usage
### Deploy Development Server
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
### Client Requests
```shell
# List books
curl -X GET \
  http://localhost:8080/book

# Create book
curl -X POST \
  -u "admin:password" \
  -H "Content-Type: application/json" \
  --data '{"title":"The Power of Geography","author":"Tim Marshall","year":2009}' \
  http://localhost:8080/book

# Read book
curl -X GET \
  -u "admin:password" \
  http://localhost:8080/book/ID

# Update book
curl -X PUT \
  -u "admin:password" \
  -H "Content-Type: application/json" \
  --data '{"title":"The Gods are to blame","author":"John Doe","year":1992}' \
  http://localhost:8080/book/ID

# Delete book
curl -X DELETE \
  -u "admin:password" \
  http://localhost:8080/book/ID
```
