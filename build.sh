#!/bin/bash

echo "Building API containers..."
sudo -E docker compose -p pithia-models-proxy up -d --build --remove-orphans
