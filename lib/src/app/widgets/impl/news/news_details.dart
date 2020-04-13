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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/utils/utils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:universal_io/prefer_universal/io.dart';

class NewsDetails extends StatefulWidget {
  final String url;
  final String source;

  NewsDetails({
    @required this.url,
    @required this.source,
  });

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'News App',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 0.27,
                color: AppTheme.darkerText,
              ),
            ),
            Text(
              'News from ${widget.source}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                letterSpacing: 0.2,
                color: AppTheme.grey,
              ),
            ),
          ],
        ),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        child: Center(
          child: Platform.isAndroid
              ? CircularProgressIndicator()
              : CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
