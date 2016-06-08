library resources;

import 'package:shelf/shelf.dart';
import 'metadata.dart';
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

