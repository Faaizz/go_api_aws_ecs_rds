FROM golang:alpine

COPY ./src /src
WORKDIR /src

RUN go build -v .
CMD [ "/src/go_api_aws_ecs_rds" ]
