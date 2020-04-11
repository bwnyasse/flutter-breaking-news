//import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking_news/src/app/blocs/blocs.dart';
import 'package:flutter_breaking_news/src/app/models/models.dart';
import 'package:flutter_breaking_news/src/app/widgets/widgets.dart';
import 'package:flutter_breaking_news/src/utils/utils.dart';
import 'package:universal_io/prefer_universal/io.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsLatest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: 8.0,
        right: 16.0,
        bottom: mediaQuery.padding.bottom + 16.0,
      ),
      child: BlocListener<DataBloc, DataState>(
        listener: (context, state) {
          if (state is DataError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<DataBloc, DataState>(
          builder: (context, state) {
            return _buildWidgetContentLatestNews(state, mediaQuery, context);
          },
        ),
      ),
    );
  }

  Widget _buildWidgetContentLatestNews(
      DataState state, MediaQueryData mediaQuery, BuildContext context) {
    if (state is DataLoading) {
      return Center(
        child: Platform.isAndroid
            ? CircularProgressIndicator()
            : CupertinoActivityIndicator(),
      );
    } else if (state is DataLoaded) {
      ArticlesResponse data = state.data;
      return ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: data.articles.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          Article itemArticle = data.articles[index];
          return index == 0
              ? buildFirstArticle(itemArticle, mediaQuery, context)
              : buildArticles(mediaQuery, itemArticle, context);
        },
      );
    } else {
      return Container();
    }
  }

  Widget buildArticles(
      MediaQueryData mediaQuery, Article itemArticle, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped. ${itemArticle.source.name}');
          },
          child: Container(
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    if (await canLaunch(itemArticle.url)) {
                      // await launch(itemArticle.url);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewsDetails(
                                  url: itemArticle.url,
                                  source: itemArticle.source.name,
                                )),
                      );
                    }
                  },
                  child: Container(
                    width: mediaQuery.size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: 72.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  itemArticle.title,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppTheme.nearlyBlack,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.launch,
                                      size: 14.0,
                                      color: Colors.lightBlue,
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      '${itemArticle.source.name}',
                                      style: TextStyle(
                                        fontSize: 11.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: ClipRRect(
                            child: itemArticle.urlToImage != null &&
                                    Uri.parse(itemArticle.urlToImage).isAbsolute
                                ? CachedNetworkImage(
                                    imageUrl: itemArticle.urlToImage,
                                    width: 90.0,
                                    height: 90.0,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Platform.isAndroid
                                            ? CircularProgressIndicator()
                                            : CupertinoActivityIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Image.asset(
                                      'assets/images/404_white.png',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.asset(
                                    'assets/images/404_white.png',
                                    width: 90.0,
                                    height: 90.0,
                                    fit: BoxFit.cover,
                                  ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(4.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack buildFirstArticle(
      Article itemArticle, MediaQueryData mediaQuery, BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          child: itemArticle.urlToImage != null &&
                  Uri.parse(itemArticle.urlToImage).isAbsolute
              ? CachedNetworkImage(
                  imageUrl: itemArticle.urlToImage,
                  height: 192.0,
                  width: mediaQuery.size.width,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Platform.isAndroid
                      ? CircularProgressIndicator()
                      : CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/404_white.png',
                    fit: BoxFit.cover,
                  ),
                )
              : Image.asset(
                  'assets/images/404_white.png',
                  height: 192.0,
                  width: mediaQuery.size.width,
                  fit: BoxFit.cover,
                ),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        GestureDetector(
          onTap: () async {
            if (await canLaunch(itemArticle.url)) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewsDetails(
                          url: itemArticle.url,
                          source: itemArticle.source.name,
                        )),
              );
              //await launch(itemArticle.url);
            } else {
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Could not launch news')),
              );
            }
          },
          child: Container(
            width: mediaQuery.size.width,
            height: 192.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [
                  0.0,
                  0.7,
                ],
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                top: 12.0,
                right: 12.0,
              ),
              child: Text(
                itemArticle.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: AppTheme.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                top: 4.0,
                right: 12.0,
              ),
              child: Wrap(
                children: <Widget>[
                  Icon(
                    Icons.launch,
                    color: Colors.lightBlue,
                    size: 12.0,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    '${itemArticle.source.name}',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: AppTheme.nearlyWhite,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
