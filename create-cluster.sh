#!/usr/bin/env bash
set -e

CLUSTER_NAME="demo-cluster"
REGISTRY_NAME="demo-registry"
REGISTRY_PORT="5001"

echo ">>> Deleting old cluster (if it exists)..."
k3d cluster delete "$CLUSTER_NAME" >/dev/null 2>&1 || true

echo ">>> Creating new k3d cluster: $CLUSTER_NAME"
k3d cluster create "$CLUSTER_NAME" \
  --servers 1 \
  --agents 2 \
  --registry-create "${REGISTRY_NAME}:0.0.0.0:${REGISTRY_PORT}" \
  -p "8080:80@loadbalancer" \
  -p "8443:443@loadbalancer"

echo ">>> Cluster created successfully."
echo ">>> Registry on host: 127.0.0.1:${REGISTRY_PORT}"
echo ">>> In-cluster registry address: ${REGISTRY_NAME}:5000"
