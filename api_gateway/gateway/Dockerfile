FROM golang:1.13-alpine

RUN apk update && apk upgrade

ENV GO113MODULE=on

WORKDIR /my_gateway

COPY go.mod .

COPY go.sum .

RUN go mod download

COPY . .

RUN go build -o main ./gateway

CMD ["./main"]


