#!/bin/bash
docker build -f Dockerfile.build-context -t build-context .
docker run --rm -it build-context
docker image rm build-context
