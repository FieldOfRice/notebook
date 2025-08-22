#!/bin/bash
docker exec -it -u 0 notebooks bash -c "cd /home/jovyan; ./rclone.sh"
