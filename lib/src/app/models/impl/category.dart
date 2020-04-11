import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Category {
  String image;
  String title;

  Category(
    this.image,
    this.title,
  );
}
