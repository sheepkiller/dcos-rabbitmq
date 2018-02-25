#!/bin/bash
set -e


FRAMEWORK_NAME=rabbitmq
FRAMEWORK_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_ROOT_DIR=$(dirname $(dirname $FRAMEWORK_DIR))
DCOS_COMMONS_SDK_DIR="${FRAMEWORK_DIR}/dcos-commons/sdk"

./gradlew clean buildDcosCommonsDeps dockerPushImage copyFiles check build distZip  --stacktrace


TEMPLATE_DOCUMENTATION_PATH="https://github.com/mesosphere/dcos-commons/blob/master/frameworks/helloworld/README.md" \
${FRAMEWORK_DIR}/tools/build_package.sh \
    rabbitmq \
    $FRAMEWORK_DIR \
    -a "$FRAMEWORK_DIR/build/distributions/rabbitmq-scheduler.zip" \
    -a "$DCOS_COMMONS_SDK_DIR/cli/dcos-service-cli-linux" \
    -a "$DCOS_COMMONS_SDK_DIR/cli/dcos-service-cli-darwin" \
    -a "$DCOS_COMMONS_SDK_DIR/cli/dcos-service-cli.exe" \
    -a "$DCOS_COMMONS_SDK_DIR/bootstrap/bootstrap.zip" \
    -a "$DCOS_COMMONS_SDK_DIR/executor/build/distributions/executor.zip" \
    aws

