#!/bin/bash

echo BUILDING IMAGES
export DOCKER_OPTS="--dns=8.8.8.8"
docker build -t multi-client ./client
wait
docker build -t multi-server ./server
wait
docker build -t multi-nginx ./nginx
wait
docker build -t multi-worker ./worker
wait
echo TAGGING IMAGES
docker tag multi-client public.ecr.aws/m4x4f7z6/docker-multi-test:multi-client
wait
docker tag multi-server public.ecr.aws/m4x4f7z6/docker-multi-test:multi-server
wait
docker tag multi-nginx public.ecr.aws/m4x4f7z6/docker-multi-test:multi-nginx
wait
docker tag multi-worker public.ecr.aws/m4x4f7z6/docker-multi-test:multi-worker
wait
echo GETTING AUTH
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws
echo PUSHING IMAGES
docker push public.ecr.aws/m4x4f7z6/docker-multi-test:multi-client
wait
docker push public.ecr.aws/m4x4f7z6/docker-multi-test:multi-server
wait
docker push public.ecr.aws/m4x4f7z6/docker-multi-test:multi-nginx
wait
docker push public.ecr.aws/m4x4f7z6/docker-multi-test:multi-worker
