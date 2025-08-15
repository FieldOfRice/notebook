#!/bin/bash
# docker run -ti --rm -e CI=TRUE -v /var/run/docker.sock:/var/run/docker.sock docker.io/wagoodman/dive vls-jupyter-lab:20250813_071747_1.0.0
docker run -ti --rm -e CI=TRUE -v /var/run/docker.sock:/var/run/docker.sock docker.io/wagoodman/dive vls-jupyter-lab:20250815_101711_1.0.0
