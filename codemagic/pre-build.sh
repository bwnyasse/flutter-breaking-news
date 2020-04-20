#!/usr/bin/env sh

set -e # exit on first failed commandset

### App Store

# bundle id of application e.g. com.stacklabs.flutterBreakingNews
export APP_ID='com.stacklabs.flutterBreakingNews.qa'

# APPLE_DEVELOPER_TEAM_ID : ***** IT IS SECRET *****

#  used by fastlane match step, this is similar to U9XX9XXXX9
# APPLE_DEVELOPER_TEAM_ID : ***** IT IS SECRET *****

# password used to log in into Apple Developer Console by fastlane
# FASTLANE_PASSWORD : ***** IT IS SECRET *****

# user used to log in into Apple Developer Console by fastlane
export FASTLANE_USER='risbonyasse@gmail.com'


# in my case it’s `dev`, `qa` and `prod`
export FLAVOR='qa'

# major and minor part of app version e.g. 1.0
export VERSION_NUMBER='1.0.0'

# this is the entry point of the app e.g. main_dev.dart
export TARGET_FILE="lib/main_$FLAVOR.dart"

# export BUILD_NUMBER  : provide by codemagic

# take a look at docs [here](https://firebase.google.com/docs/app-distribution/android/distribute-fastlane)
# FIREBASE_ANDROID_TEST_APP_ID : ***** IT IS SECRET *****

# token used by Firebase CLI, learn more [here](https://firebase.google.com/docs/cli#cli-ci-systems)
# FIREBASE_CLI_TOKEN : ***** IT IS SECRET *****

# take a look at docs [here](https://firebase.google.com/docs/app-distribution/ios/distribute-fastlane)
# FIREBASE_IOS_TEST_APP_ID : ***** IT IS SECRET *****

