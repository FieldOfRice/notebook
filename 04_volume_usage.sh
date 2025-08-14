#!/bin/bash
docker volume inspect ollama
echo "execute as root"
du -khs /var/lib/docker/volumes/ollama

