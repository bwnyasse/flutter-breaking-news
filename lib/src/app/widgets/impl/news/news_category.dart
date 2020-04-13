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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking_news/src/app/blocs/blocs.dart';
import 'package:flutter_breaking_news/src/app/models/models.dart';

class NewsCategory extends StatefulWidget {
  @override
  _NewsCategoryState createState() => _NewsCategoryState();
}

class _NewsCategoryState extends State<NewsCategory> {
  final listCategories = [
    Category('', 'All'),
    Category('assets/images/business_white.png', 'Business'),
    Category('assets/images/technology_white.png', 'Technology'),
    Category('assets/images/science_white.png', 'Science'),
    Category('assets/images/health_white.png', 'Health'),
    Category('assets/images/sport_white.png', 'Sport'),
    Category('assets/images/entertainment_white.png', 'Entertainment'),
  ];
  int indexSelectedCategory = 0;

  @override
  void initState() {
    BlocProvider.of<DataBloc>(context).add(FetchEvent(
      category: listCategories[indexSelectedCategory].title,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 74,
      child: ListView.builder(
        shrinkWrap: false,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Category itemCategory = listCategories[index];
          return Padding(
            padding: EdgeInsets.only(
              left: 16.0,
              right: index == listCategories.length - 1 ? 16.0 : 0.0,
            ),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      indexSelectedCategory = index;
                      BlocProvider.of<DataBloc>(context).add(FetchEvent(
                          category:
                              listCategories[indexSelectedCategory].title));
                    });
                  },
                  child: index == 0
                      ? Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.withOpacity(0.5),
                            border: indexSelectedCategory == index
                                ? Border.all(
                                    color: Colors.white,
                                    width: 5.0,
                                  )
                                : null,
                          ),
                          child: Icon(
                            Icons.format_align_left,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          width: 48.0,
                          height: 48.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                              image: indexSelectedCategory == index
                                  ? AssetImage(itemCategory.image.replaceAll('_white', ''))
                                  : AssetImage(itemCategory.image),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                ),
                SizedBox(height: 8.0),
                Text(
                  itemCategory.title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: indexSelectedCategory == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: listCategories.length,
      ),
    );
  }
}
