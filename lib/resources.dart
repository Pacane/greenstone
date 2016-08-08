library resources;

import 'dart:async';
import 'package:greenstone/greenstone.dart';
import 'package:shelf/shelf.dart';
import 'dart:convert';

@Group('/hello')
class SomeResource {
  @Get('/world')
  Response getSomeObject() {
    return new Response.ok('Hello World');
  }

  @Get('/double-value')
  Response withSomeQueryParams(@QueryParam() int a) {
    return new Response.ok((a * 2).toString());
  }

  @Produces.json()
  @Consumes.json()
  Response withBodyParam(@BodyParam(json) Person p) {
    final newPerson = p;
    p.age++;

    return new Response.ok(JSON.encode(newPerson.toJson()));
  }
}

@Group('/')
class AnotherGroup {
  @Get('triple')
  Response triple(@QueryParam() a) => new Response.ok(a * 3);
}

class Person {
  String name;
  int age;

  Person.fromJson(Map json) {
    name = json['name'];
    age = json['age'];
  }

  Map toJson() {
    return <String, dynamic>{'name': name, 'age': age};
  }
}

@InterceptorPath(r'/.*')
class CorsHeaderInterceptor extends Interceptor {
  @override
  Future<InterceptorResult> handleRequest(InterceptorResult previous) async {
    if (previous.request.method != 'OPTIONS') {
      return previous;
    }

    var newResponse =
        previous.response.change(headers: {"Access-Control-Allow-Origin": "*"});

    return new InterceptorResult(previous.request, newResponse);
  }
}

class CapitalizeBodyInterceptor extends Interceptor {
  @override
  Future<InterceptorResult> handleResponse(InterceptorResult previous) async {
    var body = await previous.response.readAsString();
    var newResponse = previous.response.change(body: body.toUpperCase());

    return new InterceptorResult(previous.request, newResponse);
  }
}

class AbortingInterceptor extends Interceptor {
  @override
  Future<InterceptorResult> handleRequest(InterceptorResult previous) async {
    var newResponse = new Response.forbidden('Cannot access this page');

    return new InterceptorResult(previous.request, newResponse,
        isAborted: true);
  }
}
