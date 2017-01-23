#!/bin/sh

#  CI
#
#  Created by Lee Maguire on 03/01/2017.
#  push it to the build dump repo -> create a version tag with git -> create a pod spec and push to cocoapods

echo "WE WILL NOW PUSH TO COCOAPODS ☕️"

FRAMEWORK_NAME=$1
BUILD_VERSION=$2

OUTPUT_DIR="${SRCROOT}/../../../Artifacts_Latest"

GIT_REMOTE="https://github.com/cartrawler/cartrawler-ios-build.git"
GIT_BRANCH="${FRAMEWORK_NAME}-${BUILD_VERSION}"
GIT_TAG="v${BUILD_VERSION}-${FRAMEWORK_NAME}"

cd ${OUTPUT_DIR}
echo "CHECKING OUT ${GIT_BRANCH}"
git checkout -b "${GIT_BRANCH}"
git add -A
git commit -m "${FRAMEWORK_NAME} version ${BUILD_VERSION} build ${BUILD_NUMBER}"
git tag "${GIT_TAG}"
git push "${GIT_REMOTE}" "${GIT_BRANCH}" --tags

#we have now dumped the new binaries to the build repo, lets update cocoapods next
echo "Creating podspec"
PODSPEC_TEMPLATE="${PROJECT_DIR}/PodTemplate.podspec"
cp ${PODSPEC_TEMPLATE} ${PROJECT_DIR}/${FRAMEWORK_NAME}.podspec

PODSPEC_TEMPLATE="${PROJECT_DIR}/${FRAMEWORK_NAME}.podspec"
sed -i .temp "s/FRAMEWORK_NAME/${FRAMEWORK_NAME}/g; s/FRAMEWORK_VERSION/${BUILD_VERSION}/g; s/TAG_NAME/${GIT_TAG}/g;" ${PODSPEC_TEMPLATE}

#go back to the project dir
cd "${PROJECT_DIR}/"
echo "Pushing pod spec ${PROJECT_DIR}/${FRAMEWORK_NAME}.podspec"
export LANG=en_US.UTF-8
/usr/local/bin/pod spec lint ${FRAMEWORK_NAME}.podspec
/usr/local/bin/pod repo push cartrawlerpods ${PROJECT_DIR}/${FRAMEWORK_NAME}.podspec
