import 'dart:async';
import 'dart:convert';
import 'package:greenstone/resources.dart';
import 'package:greenstone/greenstone.dart';

genericHandler(Request, Function f) => (Request) => f();

class CapitalizeBodyInterceptor extends Interceptor {
  @override
  Future<InterceptorResult> handleResponse(InterceptorResult previous) async {
    var body = await previous.response.readAsString();
    var newResponse = previous.response.change(body: body.toUpperCase());

    return new InterceptorResult(previous.request, newResponse);
  }
}

main(List<String> args) {
  final resource = new SomeResource();
  final corsInterceptor = new CorsHeaderInterceptor();
  final toUppercaseInterceptor = new CapitalizeBodyInterceptor();

  final myRouter = router();
  myRouter.get('/hello', (Request r) {
    final chain = new HandlersChain((Request r) {
      return resource.getSomeObject();
    }, [corsInterceptor, toUppercaseInterceptor]);

    return chain.run(r);
  });

  myRouter.get('/helloWithQueryParam', (Request r) {
    final chain = new HandlersChain((Request r) {
      final a = int.parse(r.requestedUri.queryParameters['a']);
      return resource.withSomeQueryParams(a);
    }, [corsInterceptor]);

    return chain.run(r);
  });

  myRouter.post('/helloWithBodyParam', (Request r) async {
    final chain = new HandlersChain((Request r) async {
      final body = await r.readAsString();
      final decodedJson = JSON.decode(body) as Map<String, dynamic>;

      final p = new Person.fromJson(decodedJson);

      return resource.withBodyParam(p);
    }, [corsInterceptor]);

    return chain.run(r);
  });

  serve(myRouter.handler, 'localhost', 8888);
}
