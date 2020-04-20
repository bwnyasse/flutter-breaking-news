#!/usr/bin/env sh

# Inspire from https://docs.codemagic.io/custom-scripts/load-firebase-configuration/

set -e # exit on first failed commandset

source $FCI_BUILD_DIR/codemagic/pre-build.sh

updateKeys() {

    echo "--- Generate Google Service Account for push to Firebase App Distribution"
    GOOGLE_SERVICE_ACCOUNT_KEY="$FCI_BUILD_DIR/firebase-appdistribution-sa-key.json"
    echo $GOOGLE_SERVICE_ACCOUNT_KEY_BASE64 | base64 --decode > $GOOGLE_SERVICE_ACCOUNT_KEY


    echo "--- Generate Google Service key for Android"
    GOOGLE_SERVICES_JSON_PATH="$FCI_BUILD_DIR/android/app/google-services.json"
    echo $GOOGLE_SERVICES_JSON_BASE64 | base64 --decode > $GOOGLE_SERVICES_JSON_PATH

    echo "--- Generate Google Service key for iOS"
    #GOOGLE_SERVICES_PLIST_TST_PATH="$FCI_BUILD_DIR/ios/Runner/Firebase/qa/GoogleService-Info.plist"
    GOOGLE_SERVICES_PLIST_TST_PATH="$FCI_BUILD_DIR/ios/Runner/GoogleService-Info.plist"
    echo $GOOGLE_SERVICES_PLIST_TST_BASE64 | base64 --decode > $GOOGLE_SERVICES_PLIST_TST_PATH
}

installFirebase() {

    # installing Firebase CLI
    curl -sL firebase.tools | bash
}

installFastlane() {

    # update fastlane and install all dependencies
    sudo gem update fastlane
    bundle update signet
    bundle install

}


##########
### MAIN

updateKeys
installFirebase
installFastlane