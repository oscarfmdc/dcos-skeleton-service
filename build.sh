#!/usr/bin/env bash
set -e

FRAMEWORK_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
REPO_ROOT_DIR=$(dirname $(dirname $FRAMEWORK_DIR))

# Build SDK artifacts (clis, bootstrap) to be included in our release, but skip SDK tests
# since that's not in our scope. Projects that aren't colocated in dcos-commons should skip
# this step, and should omit the "REPO_ROOT_DIR" artifacts listed below.
$REPO_ROOT_DIR/build.sh -b

# Build/test our scheduler.zip and keystore-app.zip
${REPO_ROOT_DIR}/gradlew -p ${FRAMEWORK_DIR} check distZip

# Build package with our scheduler.zip/keystore-app.zip and the local SDK artifacts we built:
TEMPLATE_DOCUMENTATION_PATH="https://github.com/kloudoop/dcos-skeleton-service/blob/master/README.md" \
$REPO_ROOT_DIR/tools/build_package.sh \
    skeleton \
    $FRAMEWORK_DIR \
    -a "$FRAMEWORK_DIR/build/distributions/skeleton-scheduler.zip" \
    -a "$REPO_ROOT_DIR/sdk/cli/dcos-service-cli-linux" \
    -a "$REPO_ROOT_DIR/sdk/cli/dcos-service-cli-darwin" \
    -a "$REPO_ROOT_DIR/sdk/cli/dcos-service-cli.exe" \
    $@
