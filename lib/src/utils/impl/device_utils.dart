/*
    MIT License

    Copyright (c) 2020 Boris-Wilfried Nyasse
    [ https://gitlab.com/bwnyasse | https://github.com/bwnyasse ]

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
*/

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
