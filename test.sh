#!/usr/bin/env bash

set -e

if [ -z "$CLUSTER_URL" ]; then
    if [ -z "$1" ]; then
        echo "Syntax: $0 <cluster-url>, or CLUSTER_URL=<cluster-url> $0"
        exit 1
    fi
    export CLUSTER_URL=$1
fi

REPO_ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
${REPO_ROOT_DIR}/tools/run_tests.py shakedown ${REPO_ROOT_DIR}/tests/
