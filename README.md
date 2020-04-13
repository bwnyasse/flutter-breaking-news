[![License](https://img.shields.io/static/v1?label=Licence&message=MIT&color=lightgrey)](https://img.shields.io/static/v1?label=Licence&message=MIT&color=lightgrey)

| Gitlab CI | Code Coverage | Coverage with codecov.io |
|--------------------|-------|------------------|
|[![pipeline status](https://gitlab.com/bwnyasse/flutter-breaking-news/badges/master/pipeline.svg)](https://gitlab.com/bwnyasse/flutter-breaking-news/commits/master)| [![coverage report](https://gitlab.com/bwnyasse/flutter-breaking-news/badges/master/coverage.svg)](https://gitlab.com/bwnyasse/flutter-breaking-news/commits/master) |[![codecov](https://codecov.io/gl/bwnyasse/flutter-breaking-news/branch/master/graph/badge.svg)](https://codecov.io/gl/bwnyasse/flutter-breaking-news) |

| Platform | Tests | Deploy to Firebase App Distribtion |
|--------------------|-------|------------------|
| [![Flutter](https://img.shields.io/static/v1?label=Flutter&message=ANDROID-IOS&color=informational?style=plastic&logo=flutter&logoColor=blue)](https://img.shields.io/static/v1?label=Flutter&message=ANDROID-IOS&color=blue&logo=flutter&logoColor=blue)| [![Codemagic build status](https://api.codemagic.io/apps/5e8a523364e0bd58fe01acbe/5e8a523364e0bd58fe01acbd/status_badge.svg)](https://codemagic.io/apps/5e8a523364e0bd58fe01acbe/5e8a523364e0bd58fe01acbd/latest_build) | [![Codemagic build status](https://api.codemagic.io/apps/5e8a523364e0bd58fe01acbe/5e8a523364e0bd58fe01acbd/status_badge.svg)](https://codemagic.io/apps/5e8a523364e0bd58fe01acbe/5e8a523364e0bd58fe01acbd/latest_build) |


# flutter_breaking_news

Another Flutter Open Source project.

The application will display the breaking news using [News API](https://newsapi.org/)

## App Screenshot

Here are some screenshots of the running application :

![screenshot-android](doc/screenshot-android.png)

![screenshot-iphone](doc/screenshot-iphone.png)

## Technologies

###  1. **Flutter Flavors**:

<p align="center">
<img src="doc/flavor.png" alt="drawing" width="300"/>
</p>

It is a good practice to build separate apps for different environment ( dev, prod, ...).
In case of mobile apps , the best way to have these separate configurations is usage of **flavors**

The concept of flavors is taken from Android apps and can be applied to iOS using **schemes**.

Thanks to [Dominik Roszkowski](https://github.com/orestesgaolin) for the wonderful guide that helps me 
setup Flavors in Flutter : 
 
- [Flavors in Flutter with Fastlane ](https://roszkowski.dev/2019/flutter-flavors/)

In the code , I've implemented 3 flavors : **dev**, **qa**, **prod**

<br/>

### 2. **Fastlane**:

<p align="center">
<img src="doc/fastlane.png" alt="drawing" width="200"/>
</p>


I used [Fastlane](https://fastlane.tools/) to automate apps deployments to QA environment. 

<br/>

### 3. **Firebase App Distribution**:

<p align="center">
<img src="doc/firebase-app-distribution.png" alt="drawing" width="300"/>
</p>


[Firebase App Distribution](https://firebase.google.com/docs/app-distribution) is my QA environment.
I am using the [fastlane plugin for Firebase App Distribution](https://github.com/fastlane/fastlane-plugin-firebase_app_distribution) 
to distribute apps to trusted testers.


<br/>

### 4. **Codemagic**:

<p align="center">
<img src="doc/codemagic-flutter.png" alt="drawing" width="300"/>
</p>

[Codemagic](https://codemagic.io/) offers me the possibility to implement **CI/CD**. It starts with my git repository hosted on **Gitlab**. 


## Code & Design Patterns

###  1. **BLOC**:

<p align="center">
<img src="http://flutterdevs.com/wp-content/uploads/2019/05/streams_bloc.png" alt="drawing" width="350"/>
</p>


BLoC a.k.a **Business Logic Components** is a design pattern presented by Paolo Soares and Cong hui, from Google at the DartConf 2018.

So I used Bloc, for the **state management** of the application. This design pattern helps to separate presentation from business logic.
   
### 2. JSON using code generation libraries 

I am big fan of code generation when it comes to consuming API data. According to the official documentation about [JSON and Serialization](https://flutter.dev/docs/development/data-and-backend/json)

I am using **json_annotation** + **json_serializable** to retrieve news from [News API](https://newsapi.org/)

### 3. Authentication

The auth process is handle serveless way with Google Cloud project named **[Firebase](https://firebase.google.com/)**. 
To sign in the application, you must sign in with a google account. 


## How to use

### 1. Setup Firebase 

As mentionned in the [Firebase doc](https://firebase.google.com/support/guides/google-android#migrate_your_console_project):

>Firebase manages all of your API settings and credentials through a single configuration file.
The file is named google-services.json on Android and GoogleService-Info.plist on iOS.

It makes that my .gitignore will exclude **google-services.json** and **GoogleService-Info.plist**

Follow the firebase documentation to create your project and add files with the following path : 

- $PROJECT-DIR/ios/Runner/**GoogleService-Info.plist**
- $PROJECT-DIR/android/app/**google-services.json**

My package named are : 

- for Android : **com.stacklabs.flutter_breaking_news**
- for iOS: **com.stacklabs.FlutterBreakingNews**

So, feel free to fork the projet and adapt as you like. 

### 2. Run or Build the application : 

- To run the app ( FLAVOR can be `dev`, `qa` or  `prod`)


        $> FLAVOR=dev && flutter run  --flavor $FLAVOR -t lib/main_$FLAVOR.dart
    
- To build the app ( FLAVOR can be `dev`, `qa` or  `prod`)    


        $> flutter build apk --release -t lib/main_$FLAVOR.dart --build-name=$BUILD_NAME --build-number=$BUILD_NUMBER --flavor $FLAVOR

   or 
        
        $> flutter build ios --no-codesign  --release -t lib/main_$FLAVOR.dart --build-name=$BUILD_NAME --build-number=$BUILD_NUMBER --flavor $FLAVOR
    

## Credits 


[Dominik Roszkowski](https://roszkowski.dev/) has some amazing articles that help me during the coding process.

Here are also some additional helpful resources: 

- [Distribute Flutter app to Firebase and stores from Codemagic](https://roszkowski.dev/2019/flutter-ci-cd-with-firebase-and-codemagic/)
- [Understand Flutter Flavors](https://medium.com/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b)
- [Running multiple schemes of iOS Apps](https://www.buddybuild.com/blog/running-multiple-schemes-of-ios-apps)
- [Multiple Firebase environments with Flutter](https://www.tengio.com/blog/multiple-firebase-environments-with-flutter/)


## Contribute

Have you spotted a typo, would you like to fix something, or is there something you’d like to suggest? 
Browse the source repository and open a pull request. I will do my best to review your proposal in due time.

## Issues & TODO 

[List of issues](https://gitlab.com/bwnyasse/flutter-breaking-news/-/issues)




