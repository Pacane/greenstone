import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/query.dart';
import 'domain.dart' as dsl;
import 'metadata.dart';

void validateGroupMetadata(ClassMetadata m) {}

void validateGetMetadata(MethodMetadata m) {}

class MetadataValidationException implements Exception {
  const MetadataValidationException(String message);
}

List<dsl.Group> scanGroups() {
  final context = analysisContext();
  var library = libraryMetadata(
      Uri.parse('package:greenstone/resources.dart'), context,
      annotationCreators: [
        analyzeAnnotation('Group'),
        analyzeAnnotation('Get'),
        analyzeAnnotation('Post'),
        analyzeAnnotation('QueryParam'),
        analyzeAnnotation('BodyParam'),
      ]);

  final groupSymbols = libraryMetadataQueryAll/*<ClassMetadata>*/(
          library,
          (Metadata m) =>
              (m as ClassMetadata).annotations.any((a) => a is Group),
          includeClasses: true)
      .toList();

  final groups = <dsl.Group>[];

  for (var groupClass in groupSymbols) {
    var group = new dsl.Group();

    validateGroupMetadata(groupClass);

    var groupAnnotation =
    groupClass.annotations.firstWhere((a) => a is Group) as Group;

    group.path = groupAnnotation.path;

    var getFunctions = groupClass.methods
        .where((MethodMetadata methodMeta) =>
            methodMeta.annotations.any((a) => a is Get))
        .toList();

    final endpoints = <dsl.Route>[];

    for (var function in getFunctions) {
      validateGetMetadata(function);

      var getAnnotation =
          function.annotations.singleWhere((a) => a is Get) as Get;

      var route = new dsl.Route()..path = getAnnotation.path;
      route.parameters = scanRouteParameters(function.parameters);

      endpoints.add(route);
    }

    group.routes = endpoints;

    groups.add(group);
  }

  return groups;
}

List<dsl.Parameter> scanRouteParameters(
    Iterable<ParameterMetadata> parameters) {
  final result = <dsl.Parameter>[];

  Iterable<ParameterMetadata> parametersOfType(Type parameterType) =>
      parameters.where((ParameterMetadata paramMeta) =>
          paramMeta.annotations.any((a) => a.runtimeType == parameterType));

  for (var param in parametersOfType(QueryParam)) {
    result.add(new dsl.QueryParameter()
      ..name = param.name
      ..isTypeBuiltIn = param.type.isBuiltin
      ..typeName = param.type.name);
  }

  for (var param in parametersOfType(BodyParam)) {
    result.add(new dsl.BodyParameter()
      ..name = param.name
      ..isTypeBuiltIn = param.type.isBuiltin
      ..typeName = param.type.name);
  }

  return result;
}
