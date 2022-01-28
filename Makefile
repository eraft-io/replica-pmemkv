default: image build-test

BUILDER_IMAGE := $(or $(BUILDER_IMAGE),hub.docker.com/eraftio/eraft_replica_pmemkv)

image:
	docker build -f Dockerfile -t $(BUILDER_IMAGE) .

run:
	docker run --rm -it -p 127.0.0.1:6379:6379 --user root -v ${PWD}:/replica_pmemkv hub.docker.com/eraftio/eraft_replica_pmemkv:latest /replica_pmemkv/build_/network/pmemkv_redisd /replica_pmemkv/pmem_redis.toml 

run-test:
	docker run --rm -it -p 127.0.0.1:6379:6379 --user root -v ${PWD}:/replica_pmemkv hub.docker.com/eraftio/eraft_replica_pmemkv:latest /bin/bash 

build-dev:
	chmod +x build_script.sh;
	docker run --rm -v ${PWD}:/replica_pmemkv hub.docker.com/eraftio/eraft_replica_pmemkv:latest /replica_pmemkv/build_script.sh;

test:
	docker run --rm -it -p 127.0.0.1:6379:6379 --user root -v ${PWD}:/replica_pmemkv hub.docker.com/eraftio/eraft_replica_pmemkv:latest /replica_pmemkv/build_/raftcore/test/raft_tests

clean:
	rm -rf build_
