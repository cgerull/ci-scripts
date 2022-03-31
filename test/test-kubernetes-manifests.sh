#!/bin/bash
#
# test-kubernetes-manifests.sh
# Perform a kubectl apply dry-run against the target environment.
# The calling pipeline is responsible for sufficent kubernetes credentials.
#
# Requires:
#  - kubectl
#
# Assumed locations:
#  - charts  - helm charts
#  - deploy/<environment>  -values for enviroment in the format <chart>.yaml
set -e

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <chart> <environment>"
	exit 1
fi

MANIFESTS="kubernetes"
CHART="$1"
ENVIRONMENT="$2"

if [ $(kubectl get nodes 2>&1 > /dev/null) ]; then
    echo "Performing kubectl apply dry-run for ${CHART}."
    kubectl apply -f ${MANIFESTS}/${ENVIRONMENT}/${CHART}.yaml --dry-run=client
else
    echo "ERROR: kubectl not functional, skipping tests."
fi
