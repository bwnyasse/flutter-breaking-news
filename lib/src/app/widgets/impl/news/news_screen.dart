import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking_news/src/app/blocs/blocs.dart';
import 'package:flutter_breaking_news/src/app/models/models.dart';
import 'package:flutter_breaking_news/src/app/services/services.dart';
import 'package:flutter_breaking_news/src/app/widgets/widgets.dart';
import 'package:flutter_breaking_news/src/utils/utils.dart';
import 'package:universal_io/prefer_universal/io.dart';
import 'package:url_launcher/url_launcher.dart';

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
              getStrToday(),
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
