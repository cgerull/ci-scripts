#!/bin/bash
#
#
# build-helm-package.sh
# Test and package a helm chart. 
# Assume that the chart is the charts folder. If that folder don't
# exists the chart should be in PWD.
#
# Requires:
#  - helm
#  - yq
set -e

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <chart> <version_var>"
	exit 1
fi

CHART_DIR="charts"
CHART="$1"
BUILD_VERSION="$2"

# Get relative chart path
if [ -d ${CHART_DIR} ]; then
    CHART_PATH="${CHART_DIR}/${CHART}"
fi

# First do a static analysis
helm lint "${CHART_PATH}"
# Set build version
CHART_VERSION=$(cat ${CHART_PATH}/Chart.yaml | yq '.version')
# Create helm chart package per environment
helm package "${CHART_PATH}" --version ${CHART_VERSION}-${BUILD_VERSION}
