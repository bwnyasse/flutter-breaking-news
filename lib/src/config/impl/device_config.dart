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

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/config/config.dart';
import 'package:flutter_breaking_news/src/utils/utils.dart' as utils;

class DeviceConfig extends StatelessWidget {
  DeviceConfig();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(bottom: 10.0),
      title: Container(
        padding: EdgeInsets.all(15.0),
        color: FlavorConfig.instance.color,
        child: Text(
          'Device Info',
          style: TextStyle(color: Colors.white),
        ),
      ),
      titlePadding: EdgeInsets.all(0),
      content: _getContent(),
    );
  }

  Widget _getContent() {
    if (Platform.isAndroid) {
      return _androidContent();
    }

    if (Platform.isIOS) {
      return _iOSContent();
    }

    return Text("You're not on Android neither iOS");
  }

  Widget _iOSContent() {
    return FutureBuilder(
        future: utils.iosDeviceInfo(),
        builder: (context, AsyncSnapshot<IosDeviceInfo> snapshot) {
          if (!snapshot.hasData) return Container();

          IosDeviceInfo device = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTile('Flavor:', '${FlavorConfig.instance.name}'),
                _buildTile('Build mode:',
                    '${utils.enumName(utils.currentBuildMode().toString())}'),
                _buildTile('Physical device?:', '${device.isPhysicalDevice}'),
                _buildTile('Device:', '${device.name}'),
                _buildTile('Model:', '${device.model}'),
                _buildTile('System name:', '${device.systemName}'),
                _buildTile('System version:', '${device.systemVersion}')
              ],
            ),
          );
        });
  }

  Widget _androidContent() {
    return FutureBuilder(
        future: utils.androidDeviceInfo(),
        builder: (context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
          if (!snapshot.hasData) return Container();

          AndroidDeviceInfo device = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTile('Flavor:', '${FlavorConfig.instance.name}'),
                _buildTile('Build mode:',
                    '${utils.enumName(utils.currentBuildMode().toString())}'),
                _buildTile('Physical device?:', '${device.isPhysicalDevice}'),
                _buildTile('Manufacturer:', '${device.manufacturer}'),
                _buildTile('Model:', '${device.model}'),
                _buildTile('Android version:', '${device.version.release}'),
                _buildTile('Android SDK:', '${device.version.sdkInt}')
              ],
            ),
          );
        });
  }

  Widget _buildTile(String key, String value) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Text(
            key,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value)
        ],
      ),
    );
  }
}
