import 'package:flutter_breaking_news/src/utils/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("enumName", () {
    expect(enumName("1.2.3"), "3");
  });

  test('getStrDate', () {
    expect(getStrDate(DateTime(2020, 10, 1)), '1st October 2020');
    expect(getStrDate(DateTime(2020, 10, 2)), '2nd October 2020');
    expect(getStrDate(DateTime(2020, 10, 3)), '3rd October 2020');
  });

}
