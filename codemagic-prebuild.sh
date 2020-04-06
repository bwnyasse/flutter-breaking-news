#!/usr/bin/env sh

# Inspire from https://docs.codemagic.io/custom-scripts/load-firebase-configuration/ 
    
set -e # exit on first failed commandset

echo "--- Generate FIREBASE_APP_DISTRIBUTION_SECRET "
echo $FIREBASE_APP_DISTRIBUTION_SECRET | base64 --decode > $FCI_BUILD_DIR/firebase-appdistribution-sa-key.json

echo "--- Generate ANDROID_FIREBASE_SECRET "
echo $ANDROID_FIREBASE_SECRET | base64 --decode > $FCI_BUILD_DIR/android/app/google-services.json

echo "--- Generate IOS_FIREBASE_SECRET "
echo $IOS_FIREBASE_SECRET | base64 --decode > $FCI_BUILD_DIR/ios/Runner/GoogleService-Info.plist

