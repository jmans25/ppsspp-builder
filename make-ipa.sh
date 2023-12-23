#!/bin/bash

if [[ ! -d ppsspp ]];then
	echo "You are using this script in the wrong path!"
	exit 1
fi

cd ppsspp
mkdir build-ios
cd build-ios
sed -i '' 's#if(GIT_FOUND AND EXISTS "${SOURCE_DIR}/.git/")#if(GIT_FOUND)#' ../git-version.cmake
cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/Toolchains/ios.cmake -GXcode ..
xcodebuild clean build CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO PRODUCT_BUNDLE_IDENTIFIER="org.ppsspp.ppsspp" -sdk iphoneos -configuration Release
ln -sf Release-iphoneos Payload
echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>platform-application</key>
	<true/>
	<key>get-task-allow</key>
	<true/>
</dict>
</plist>' > ent.xml
ldid -Sent.xml Payload/PPSSPP.app/PPSSPP
version_number=`echo "$(git describe --tags --match="v*" | sed -e 's@-\([^-]*\)-\([^-]*\)$@-\1-\2@;s@^v@@;s@%@~@g')"`
zip -r9 ../../PPSSPP_v${version_number}.ipa Payload/PPSSPP.app
sed -i '' 's#if(GIT_FOUND)#if(GIT_FOUND AND EXISTS "${SOURCE_DIR}/.git/")#' ../git-version.cmake
echo "ipa built"
