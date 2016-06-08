import 'package:shelf/shelf.dart';
import 'package:shelf_route/shelf_route.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'dart:convert';
import 'package:greenstone/resources.dart';

genericHandler(Request, Function f) => (Request) => f();

main(List<String> args) {
  final resource = new SomeResource();

  final myRouter = router();
  myRouter.get('/hello', (Request r) => resource.getSomeObject());


  myRouter.get('/helloWithQueryParam', (Request r) {
    final a = int.parse(r.requestedUri.queryParameters['a']);
    return resource.withSomeQueryParams(a);
  });

  myRouter.post('/helloWithBodyParam', (Request r) async {
    final body = await r.readAsString();
    final decodedJson = JSON.decode(body) as Map<String, dynamic>;

    final p = new Person.fromJson(decodedJson);

    return resource.withBodyParam(p);
  });

  shelf_io.serve(myRouter.handler, 'localhost', 8888);
}
