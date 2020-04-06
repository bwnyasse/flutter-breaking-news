#!/usr/bin/env sh

# Inspire from https://docs.codemagic.io/custom-scripts/load-firebase-configuration/ 
    
set -e # exit on first failed commandset

echo $ANDROID_FIREBASE_SECRET | base64 --decode > $FCI_BUILD_DIR/android/app/google-services.json
echo $IOS_FIREBASE_SECRET | base64 --decode > $FCI_BUILD_DIR/ios/Runner/GoogleService-Info.plist