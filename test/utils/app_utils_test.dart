import 'package:flutter_breaking_news/src/utils/impl/app_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test("enumName", (){
    expect("3", enumName("1.2.3"));
  });

}
