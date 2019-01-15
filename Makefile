.PHONY: build push test

build:
	docker build -t hhansen06/osrm-server .

push: build
	docker push hhansen06/osrm-server:latest

test: build
	docker run -p 5000:5000 -d hhansen06osrm-server run
