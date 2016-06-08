class QueryParam {
  final String name;

  const QueryParam(this.name);
}

class Group {
  final String path;

  const Group(this.path);
}

class BodyParam {
  final String name;

  const BodyParam(this.name);
}

class Get {
  final String path;

  const Get(this.path);
}

class Post {
  final String path;

  const Post(this.path);
}

class Produces {
  const Produces.json();
  const Produces.stream();
  const Produces.string();
}

class Consumes {
  const Consumes.json();
}
