#!/usr/bin/env bash
set -euo pipefail

NAMESPACE="demo-ns"
SERVICE_URL="http://demo-service.${NAMESPACE}.svc.cluster.local"
COUNT="${1:-5}"

echo ">>> Starting ${COUNT} load generator pods in namespace ${NAMESPACE}"
echo ">>> Target: ${SERVICE_URL}"

for i in $(seq 1 "$COUNT"); do
  POD_NAME="load-generator-${i}"

  # Create the pod (idempotent-ish: delete if already exists)
  kubectl delete pod "$POD_NAME" -n "$NAMESPACE" --ignore-not-found >/dev/null 2>&1 || true

  kubectl run "$POD_NAME" \
    -n "$NAMESPACE" \
    --image=busybox \
    --restart=Never \
    --labels="app=load-generator" \
    -- /bin/sh -c "while true; do wget -q -O- ${SERVICE_URL} > /dev/null; done" >/dev/null

  echo "  - started $POD_NAME"
done

echo ">>> Done. Check with: kubectl get pods -n ${NAMESPACE} -l app=load-generator"
