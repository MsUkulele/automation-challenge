#!/usr/bin/env bash
set -e

CLUSTER_NAME="demo"

echo ">>> Deleting old cluster (if it exists)..."
k3d cluster delete "$CLUSTER_NAME" >/dev/null 2>&1 || true

echo ">>> Creating new k3d cluster: $CLUSTER_NAME"
k3d cluster create "$CLUSTER_NAME" \
  --servers 1 \
  --agents 2 \
  -p "8080:80@loadbalancer"

echo ">>> Cluster created successfully."
echo ">>> You can now run: kubectl get nodes"

