import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'metadata.dart';

class SomeGenerator extends GeneratorForAnnotation<Group> {
  const SomeGenerator();
  final int a = 12;
  @override
  Future<String> generateForAnnotatedElement(
      Element element, Group annotation, BuildStep buildStep) async {

    return '';

  }
}
