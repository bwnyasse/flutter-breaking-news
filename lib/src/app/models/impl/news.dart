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

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

///
///  SOURCE
///
@JsonSerializable()
class Source extends Equatable {
  final String id;
  final String name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  @override
  List<Object> get props => [
        this.id,
        this.name,
      ];
}

///
///  ARTICLE
///
@JsonSerializable()
class Article extends Equatable {
  final Source source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  @override
  List<Object> get props => [
        this.source,
        this.author,
        this.title,
        this.description,
        this.url,
        this.urlToImage,
        this.publishedAt,
        this.content,
      ];
}

///
/// ARTICLES RESPONSE FROM SERVER
///
@JsonSerializable()
class ArticlesResponse extends Equatable {
  String status;
  int totalResults;
  List<Article> articles;

  @JsonKey(ignore: true)
  dynamic error;

  @JsonKey(ignore: true)
  dynamic stackTrace;

  ArticlesResponse({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory ArticlesResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticlesResponseFromJson(json);

  ArticlesResponse.withError({this.error, this.stackTrace});

  @override
  List<Object> get props => [
        this.status,
        this.totalResults,
        this.articles,
      ];
}
