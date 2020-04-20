#!/usr/bin/env bash
#
# Script used to build apk in dev environment
#

set -e

CURRENT_DIR=$(pwd)

[[ ! -f "$CURRENT_DIR/pubspec.yaml" ]] && echo 'the script must be run into flutter root directory' && exit 1


################
## FLAG VAR  ##
###############
FLAGS="iah"

FLAG_IOS=false
FLAG_ANDROID=false

##############################
## FUNCTIONS DECLARATION  ###
#############################

usage() {
	cat <<-EOF
    Script used to build apk in dev environment
	OPTIONS:
	========
      -i	  build for ios
      -a	  build for android
      -h	  show this help
	EOF
}

FLAVOR=qa
BUILD_NAME='1.0.0'
BUILD_NUMBER='1'


#############################
### Effectif Script build ###
############################


while getopts $FLAGS OPT;
do
    case $OPT in
        i)
            FLAG_IOS=true
            ;;
        a)
            FLAG_ANDROID=true
            ;;
        *|h)
            usage
            exit 1
            ;;
    esac
done


<<COMMENT1
If you are deploying the app to the Play Store, it's recommended to use app bundles or split the APK to reduce the APK size.
    To generate an app bundle, run:
        flutter build appbundle --target-platform android-arm,android-arm64,android-x64
        Learn more on: https://developer.android.com/guide/app-bundle
    To split the APKs per ABI, run:
        flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi
        Learn more on:  https://developer.android.com/studio/build/configure-apk-splits#configure-abi-split
COMMENT1
if $FLAG_ANDROID; then

    flutter build apk --release \
                            -t lib/main_$FLAVOR.dart \
                            --build-name=$BUILD_NAME \
                            --build-number=$BUILD_NUMBER \
                            --flavor $FLAVOR

fi

if $FLAG_IOS; then

    flutter build ios --no-codesign  --release \
                             -t lib/main_$FLAVOR.dart \
                             --build-name=$BUILD_NAME \
                             --build-number=$BUILD_NUMBER \
                             --flavor $FLAVOR

fi
