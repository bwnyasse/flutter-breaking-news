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
