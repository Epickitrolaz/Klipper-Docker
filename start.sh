#!/bin/bash
podman compose down
podman compose up -d --build --force-recreate
