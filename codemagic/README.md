## My MEMO of Environnement Variables

### Play Store

- ANDROID_KEYSTORE_ALIAS
- ANDROID_KEYSTORE_PASSWORD
- ANDROID_KEYSTORE_PATH
- ANDROID_KEYSTORE_PRIVATE_KEY_PASSWORD
- FCI_KEYSTORE_FILE : encoded Android keystore

### App Store

- APP_ID : bundle id of application e.g. com.stacklabs.FlutterBreakingNews
- APP_STORE_CONNECT_TEAM_ID
- APPLE_DEVELOPER_TEAM_ID : used by fastlane match step, this is similar to U9XX9XXXX9
- FASTLANE_PASSWORD : password used to log in into Apple Developer Console by fastlane
- FASTLANE_USER : user used to log in into Apple Developer Console by fastlane

### FIREBASE

- FIREBASE_ANDROID_TEST_APP_ID : take a look at docs [here](https://firebase.google.com/docs/app-distribution/android/distribute-fastlane)
- FIREBASE_CLI_TOKEN : token used by Firebase CLI, learn more [here](https://firebase.google.com/docs/cli#cli-ci-systems)
- FIREBASE_IOS_TEST_APP_ID : take a look at docs [here](https://firebase.google.com/docs/app-distribution/ios/distribute-fastlane)
- FIREBASE_TESTERS - name of testers group that app should be distributed to

#### FIREBASE ACCESS SERVICE KEYS

- GOOGLE_SERVICE_ACCOUNT_KEY_BASE64
- GOOGLE_SERVICE_ACCOUNT_KEY
- GOOGLE_SERVICES_JSON_BASE64
- GOOGLE_SERVICES_JSON_PATH
- GOOGLE_SERVICES_PLIST_BASE64
- GOOGLE_SERVICES_PLIST_PATH


### Build Project

- FLAVOR : in my case it’s `dev`, `qa` and `prod`
- APK_PATH : required for Firebase step to find correct apk file ( unused)

- CI - Codemagic theoretically has this variable set, but for some reason in my build fastlane had problems with respecting it, so I added it on my own with some dummy value
- KEYCHAIN_NAME : we need to create temporary keychain to store Apple credentials
- MATCH_PASSWORD : password used to encrypt provisioning profiles and certificates in the private repository, learn more [here](https://docs.fastlane.tools/actions/match/)
- TARGET_FILE : this is the entry point of the app e.g. main_dev.dart
- VERSION_NUMER : major and minor part of app version e.g. 1.0