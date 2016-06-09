class Group {
  String path;
  List<Route> routes = <Route>[];
}

class Route {
  String path;
  List<Parameter> parameters = <Parameter> [];
}

abstract class Parameter {
  String prettyName;
  String name;
}

enum Method {
  get, post, put, patch
}