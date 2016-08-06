import 'package:test/test.dart';
import 'package:uri/uri.dart';
import 'package:uri/matchers.dart';

void main() {
  test('uri vs string', () {
    var template = new UriTemplate(r'/.*');
    var uriPattern = new UriParser(template);
    expect(uriPattern.matches(Uri.parse('/hello')), isTrue);
  });
}