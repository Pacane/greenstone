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

  Response withSomeQueryParams(@QueryParam('a') int a) {
    return new Response.ok((a * 2).toString());
  }

  @Produces.json()
  @Consumes.json()
  Response withBodyParam(@BodyParam('a') Person a) {
    final newPerson = a;
    a.age++;

    return new Response.ok(JSON.encode(newPerson.toJson()));
  }
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
