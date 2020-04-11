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
