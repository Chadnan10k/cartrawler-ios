#!/bin/sh
set -e

export FRAMEWORK_LOCN="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.framework"

# Create the path to the real Headers die
mkdir -p "${FRAMEWORK_LOCN}/Versions/A/Headers"

# Create the required symlinks
/bin/ln -sfh A "${FRAMEWORK_LOCN}/Versions/Current"
/bin/ln -sfh Versions/Current/Headers "${FRAMEWORK_LOCN}/Headers"
/bin/ln -sfh "Versions/Current/${PRODUCT_NAME}" \
"${FRAMEWORK_LOCN}/${PRODUCT_NAME}"

# Copy the public headers into the framework
/bin/cp -a "${TARGET_BUILD_DIR}/${PUBLIC_HEADERS_FOLDER_PATH}/" \
"${FRAMEWORK_LOCN}/Versions/A/Headers"

#appledoc Xcode script
# Start constants
company="Cartrawler";
companyID="com.cartrawler";
companyURL="http://cartrawler.com";
target="iphoneos";

buildPlist="Info.plist"
buildVersion=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" $buildPlist)

outputPath="${PROJECT_DIR}/Cartrawler API Documentation";
# End constants

jazzy \
--objc  \
--clean \
--skip-undocumented \
--author Cartrawler \
--min-acl public \
--umbrella-header CartrawlerAPI/CartrawlerAPI.h \
--framework-root . \
--theme apple \
--output docs

#"${PROJECT_DIR}"
