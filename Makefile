default: image build-test

BUILDER_IMAGE := $(or $(BUILDER_IMAGE),hub.docker.com/eraftio/eraft_uhp_sql)

image:
	docker build -f Dockerfile -t $(BUILDER_IMAGE) .

run:
	docker run -it -p 127.0.0.1:6379:6379 --user root -v ${PWD}:/pmemkv hub.docker.com/eraftio/eraft_uhp_sql:latest /pmemkv/build_/network/pmemkv_redisd /pmemkv/pmem_redis.toml 

run-test:
	docker run -it -p 127.0.0.1:6379:6379 --user root -v ${PWD}:/pmemkv hub.docker.com/eraftio/eraft_uhp_sql:latest /bin/bash 

build-dev:
	chmod +x build_script.sh;
	docker run --rm -v ${PWD}:/pmemkv hub.docker.com/eraftio/eraft_uhp_sql:latest /pmemkv/build_script.sh;

clean:
	rm -rf build_
