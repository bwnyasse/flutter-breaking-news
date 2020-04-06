import 'package:device_info/device_info.dart';

enum BuildMode {
  DEBUG,
  PROFILE,
  RELEASE,
}

BuildMode currentBuildMode() {
  if (const bool.fromEnvironment('dart.vm.product')) {
    return BuildMode.RELEASE;
  }
  var result = BuildMode.PROFILE;

//Little trick, since assert only runs on DEBUG mode
  assert(() {
    result = BuildMode.DEBUG;
    return true;
  }());
  return result;
}

Future<AndroidDeviceInfo> androidDeviceInfo() async {
  DeviceInfoPlugin plugin = DeviceInfoPlugin();
  return plugin.androidInfo;
}

Future<IosDeviceInfo> iosDeviceInfo() async {
  DeviceInfoPlugin plugin = DeviceInfoPlugin();
  return plugin.iosInfo;
}
