#!/bin/bash

if [[ ! -d ppsspp ]];then
	echo "You are using this script in the wrong path!"
	exit 1
fi

cd ppsspp
mkdir build-ios
cd build-ios
/bin/bash -c "sudo xcode-select -s /Applications/Xcode_11.7.app/Contents/Developer"
sed -i '' 's#if(GIT_FOUND AND EXISTS "${SOURCE_DIR}/.git/")#if(GIT_FOUND)#' ../git-version.cmake
cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/Toolchains/ios.cmake -GXcode .. -- CODE_SIGNING_REQUIRED=NO
xcodebuild clean build CODE_SIGNING_REQUIRED=NO PRODUCT_BUNDLE_IDENTIFIER="org.ppsspp.ppsspp" -sdk iphoneos -configuration Release # CODE_SIGN_IDENTITY=""
ln -sf Release-iphoneos Payload
version_number=`echo "$(git describe --tags --match="v*" | sed -e 's@-\([^-]*\)-\([^-]*\)$@-\1-\2@;s@^v@@;s@%@~@g')"`
zip -r9 ../../PPSSPP_v${version_number}.ipa Payload/PPSSPP.app
sed -i '' 's#if(GIT_FOUND)#if(GIT_FOUND AND EXISTS "${SOURCE_DIR}/.git/")#' ../git-version.cmake
echo "ipa built"
