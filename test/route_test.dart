import 'package:test/test.dart';
import 'package:greenstone/dsl.dart';

main() {
  group('computedPath', () {
    test('with no parameter and no segment should be root', () {
      final segments = [new PathSegment('')];
      final route = new Route(segments);

      expect(route.computedRoute, '/');
    }, skip: true);

    test('with no parameter and only one path segment', () {
      final segments = [new PathSegment('hello')];
      final route = new Route(segments);

      expect(route.computedRoute, '/hello');
    });

    test('with one query parameter and one path segment', () {
      final segments = [
        new PathSegment('hello', parameters: [new QueryParameter('foo')])
      ];
      final route = new Route(segments);

      expect(route.computedRoute, '/hello?{foo}');
    });
  });
}
