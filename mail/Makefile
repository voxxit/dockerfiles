.PHONY: build push

build:
	docker build --tag r.srv.im/mta:latest ./mta

test: build
	docker run --rm -it r.srv.im/mta:latest bats /tests.bats

push:
	docker push r.srv.im/mta:latest
