#!/usr/bin/env bash
set -euo pipefail

# obține subscription id
SUB_ID=$(az account show --query id -o tsv)
echo "Using subscription: $SUB_ID"

# creează un nume stabil pentru SP
TIMESTAMP=$(date +%s)
SP_NAME="tf-backend-sp-${TIMESTAMP}"

# scope pentru Storage Account (înlocuiește dacă e nevoie)
SCOPE="/subscriptions/${SUB_ID}/resourceGroups/rg-terraform-test/providers/Microsoft.Storage/storageAccounts/stterraform676436e2"

echo "Creating service principal '${SP_NAME}' with role Storage Blob Data Contributor on scope:"
echo "  $SCOPE"

az ad sp create-for-rbac --name "${SP_NAME}" \
  --role "Storage Blob Data Contributor" \
  --scopes "${SCOPE}" \
  -o json
