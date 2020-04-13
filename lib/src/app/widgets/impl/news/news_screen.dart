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

import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:flutter_breaking_news/src/app/widgets/widgets.dart';
import 'package:flutter_breaking_news/src/utils/utils.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  LocalStorageService localStorageService;
  String countryFlagValue = 'ar';

  @override
  void initState() {
    localStorageService = Provider.of<LocalStorageService>(
      context,
      listen: false,
    );
    localStorageService.getData().then((data) {
      setState(() {
        countryFlagValue = data.countryFlag ?? 'ar';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            appBarUI(),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: <Widget>[
                      getCategoryUI(),
                      Flexible(
                        child: getNewsUI(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
          child: Row(
            children: <Widget>[
              Text(
                'News Today',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.27,
                  color: AppTheme.darkerText,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        NewsCategory(),
      ],
    );
  }

  Widget getNewsUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 25.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 18, right: 16),
            child: Row(
              children: <Widget>[
                Text(
                  'Last News',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    letterSpacing: 0.27,
                    color: AppTheme.darkerText,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                      Flags.getMiniFlag(countryFlagValue.toUpperCase(), 16, 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 18, right: 16),
            child: Text(
              getStrDate(DateTime.now()),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                letterSpacing: 0.27,
                color: AppTheme.darkerText,
              ),
            ),
          ),
          Expanded(
            child: NewsLatest(),
          )
        ],
      ),
    );
  }
}
