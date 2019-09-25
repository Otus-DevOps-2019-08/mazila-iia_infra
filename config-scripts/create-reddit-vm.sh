#!/bin/bash

gcloud beta compute --project=infra-253205 instances create instance-1 \
--zone=europe-west1-b \
--machine-type=f1-micro \
--subnet=default \
--network-tier=PREMIUM \
--maintenance-policy=MIGRATE \
--service-account=38590238083-compute@developer.gserviceaccount.com \
--scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
--tags=puma-server \
--image=reddit-full-1569330901 \
--image-project=infra-253205 \
--boot-disk-size=10GB \
--boot-disk-type=pd-standard \
--boot-disk-device-name=instance-1 \
--reservation-affinity=any
