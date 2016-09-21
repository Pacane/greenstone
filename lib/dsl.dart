class Group {
  final List<PathSegment> pathSegments;

  Group(this.pathSegments);
}

class PathSegment {
  final String name;
  final List<Parameter> parameters;

  PathSegment(this.name, {this.parameters: const <Parameter>[]});
}

class Route {
  final List<PathSegment> pathSegments;

  Route(this.pathSegments);

  String get computedRoute =>
      pathSegments.fold('', (String previous, PathSegment segment) {
        final withoutParameters = '$previous/${segment.name}';

        var queryParametersCount = 0;
        final withQueryParameters = segment.parameters.fold(withoutParameters,
            (String previous, Parameter parameter) {
          if (parameter is PathParameter) {
            return '$previous/{${parameter.name}}';
          }

          if (parameter is QueryParameter) {
            if (queryParametersCount == 0) {
              queryParametersCount++;
              return '$previous?{${parameter.name}}';
            } else {
              return '$previous&{${parameter.name}';
            }
          }
        });
        return withQueryParameters;
      });
}

class Parameter {
  final String name;
  final dynamic value;

  Parameter(this.name, {this.value});
}

class PathParameter extends Parameter {
  PathParameter(String name, {dynamic value}) : super(name, value: value);
}

class QueryParameter extends Parameter {
  QueryParameter(String name, {dynamic value}) : super(name, value: value);
}
