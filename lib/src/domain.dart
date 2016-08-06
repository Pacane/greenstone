import 'dart:async';
import 'package:shelf/shelf.dart';

class Group {
  String path;
  List<Route> routes = <Route>[];
}

class Route {
  String path;
  List<Parameter> parameters = <Parameter>[];
}

abstract class Parameter {
  String prettyName;
  String name;
}

enum Method { get, post, put, patch }

class InterceptorResult {
  Request request;
  Response response;
  bool isAborted;

  InterceptorResult(this.request, this.response, {this.isAborted: false});
}

abstract class Interceptor {
  Future<InterceptorResult> handleRequest(InterceptorResult previous) async =>
      previous;

  Future<InterceptorResult> handleResponse(InterceptorResult previous) async =>
      previous;
}

class HandlersChain {
  List<Interceptor> interceptors = [];
  Handler handler;

  HandlersChain(this.handler, [this.interceptors]);

  Future<Response> run(Request request) async {
    var interceptorResult = new InterceptorResult(request, null);

    for (var interceptor in interceptors) {
      interceptorResult = await interceptor.handleRequest(interceptorResult);

      if (interceptorResult.isAborted) {
        return interceptorResult.response;
      }
    }

    interceptorResult.response = await handler(request);

    for (var interceptor in interceptors) {
      interceptorResult = await interceptor.handleResponse(interceptorResult);

      if (interceptorResult.isAborted) {
        return interceptorResult.response;
      }
    }

    return interceptorResult.response;
  }
}
