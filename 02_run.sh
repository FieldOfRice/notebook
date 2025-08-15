#!/bin/bash

( sleep 10; echo "---"; echo "docker exec -it -u 0 notebooks; /home/jovyan/rclone.sh"; echo "---" ) & 
# a fine grained rclone related apparmor profile to be used here, but root/sudo needed to load and it hasn't been created/verified yet
docker run -it --security-opt apparmor=unconfined --cap-add SYS_ADMIN --device /dev/fuse -e NOTEBOOK_ARGS="--IdentityProvider.token='' --PasswordIdentityProvider.hashed_password=''" --name notebooks --rm -p 127.0.0.1:17777:8888 -e OLLAMA_HOST=192.168.178.144:11434 --gpus all -v notebook:/tmp/notebook vls-jupyter-lab:20250815_101711_1.0.0

