#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="demo-ns"

echo ">>> Deleting all load generator pods in namespace ${NAMESPACE}"
kubectl delete pod -n "$NAMESPACE" -l app=load-generator --ignore-not-found

echo ">>> Remaining load pods:"
kubectl get pods -n "$NAMESPACE" -l app=load-generator || true
