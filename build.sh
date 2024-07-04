#!/bin/bash

echo "Building API containers..."
sudo -E docker compose -p models-proxy-ssl up -d --build --remove-orphans
