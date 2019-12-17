#!/bin/bash

export COMPOSE_CONVERT_WINDOWS_PATHS=1
docker network create "ml-cloud-network-east"
docker volume create "userdata"
docker-compose  --compatibility up -f "$PWD//docker-compose-east-framework.yml" up -d msapigateway-east-server1
docker-compose  --compatibility up -f "$PWD//docker-compose-east.yml" up -d mlserver-east
#docker network create ml-cloud-network-west
#docker volume create mlservicedatadir-west
#docker-compose  --compatibility up -f "$PWD//docker-compose-west-framework.yml" up msapigateway-west-server1
#docker-compose  --compatibility up -f "$PWD//docker-compose-west.yml" up mlserver-west
