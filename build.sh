#!/bin/bash
# export DOCKER_BUILDKIT=0
export BUILDKIT_PROGRESS=plain
# docker compose build
# docker container rm -f sftp-server-ssv-1
# docker volume rm sftp-server_data
docker compose up --build

