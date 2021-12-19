
.PHONY: build run clean

all: build run

build: 
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

run:
	docker build -t my-server:alpine .
	docker run -d -p 8080:8080 --name my-server -v /data/transmission:/data my-server:alpine

stop: 
	docker stop my-server
	docker rm -f my-server
	
clean: 
	rm -f server

list:
	docker ps -a
	docker images
