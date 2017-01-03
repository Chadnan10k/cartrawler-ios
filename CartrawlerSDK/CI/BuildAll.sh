#!/bin/sh

#  BuildAll.sh
#  CI
#
#  Created by Lee Maguire on 03/01/2017.
#

echo "Building API"
/usr/bin/xcodebuild build -workspace "${SRCROOT}/../CartrawlerSDK.xcworkspace" -scheme BuildAPI
echo "Building SDK"
/usr/bin/xcodebuild build -workspace "${SRCROOT}/../CartrawlerSDK.xcworkspace" -scheme BuildSDK
echo "Building Rental"
/usr/bin/xcodebuild build -workspace "${SRCROOT}/../CartrawlerSDK.xcworkspace" -scheme BuildRental
echo "Building InPath"
/usr/bin/xcodebuild build -workspace "${SRCROOT}/../CartrawlerSDK.xcworkspace" -scheme BuildInPath


PODSPEC_TEMPLATE="${PROJECT_DIR}/PodTemplate.podspec"
#copy the spec for the two frameworks
cp ${PODSPEC_TEMPLATE} ${PROJECT_DIR}/CartrawlerAPI.podspec
cp ${PODSPEC_TEMPLATE} ${PROJECT_DIR}/CartrawlerSDK.podspec
cp ${PODSPEC_TEMPLATE} ${PROJECT_DIR}/CartrawlerRental.podspec
cp ${PODSPEC_TEMPLATE} ${PROJECT_DIR}/CartrawlerInPath.podspec

BUILD_VERSION="2.0.0"
TAG="CT-2.0.0"


PODSPEC_TEMPLATE="${PROJECT_DIR}/CartrawlerAPI.podspec"
sed -i .temp "s/FRAMEWORK_NAME/CartrawlerAPI/g; s/FRAMEWORK_VERSION/${BUILD_VERSION}/g; s/TAG_NAME/${TAG}/g;" ${PODSPEC_TEMPLATE}

PODSPEC_TEMPLATE="${PROJECT_DIR}/CartrawlerSDK.podspec"
sed -i .temp "s/FRAMEWORK_NAME/CartrawlerSDK/g; s/FRAMEWORK_VERSION/${BUILD_VERSION}/g; s/TAG_NAME/${TAG}/g;" ${PODSPEC_TEMPLATE}

PODSPEC_TEMPLATE="${PROJECT_DIR}/CartrawlerRental.podspec"
sed -i .temp "s/FRAMEWORK_NAME/CartrawlerRental/g; s/FRAMEWORK_VERSION/${BUILD_VERSION}/g; s/TAG_NAME/${TAG}/g;" ${PODSPEC_TEMPLATE}

PODSPEC_TEMPLATE="${PROJECT_DIR}/CartrawlerInPath.podspec"
sed -i .temp "s/FRAMEWORK_NAME/CartrawlerInPath/g; s/FRAMEWORK_VERSION/${BUILD_VERSION}/g; s/TAG_NAME/${TAG}/g;" ${PODSPEC_TEMPLATE}

