#! /usr/bin/env bash

# Uses the default plans "small" and "medium"
# Uses a custom plan called "singleVM" that has one worker node with good specs
# Change as you see fit. These numbers work for my lab and my workloads

tkgi create-cluster concourse \
--external-hostname=k8s-concourse.$PRIMARY_DOMAIN \
--plan=singleVM

tkgi create-cluster harbor \
--external-hostname=k8s-harbor.$PRIMARY_DOMAIN \
--plan=singleVM

tkgi create-cluster tbs \
--external-hostname=k8s-tbs.$PRIMARY_DOMAIN \
--plan=medium \
--num-nodes=2

tkgi create-cluster spring-petclinic \
--external-hostname=k8s-spring-petclinic.$PRIMARY_DOMAIN \
--plan=small \
--num-nodes 1
