class QueryParam {
  const QueryParam();
}

class Group {
  final String path;

  const Group(this.path);
}

enum BodyType { json, binary, text, form }

const BodyType json = BodyType.json;
const BodyType binary = BodyType.binary;
const BodyType text = BodyType.text;
const BodyType form = BodyType.form;

class BodyParam {
  final BodyType bodyType;

  const BodyParam(this.bodyType);
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

class InterceptorPath {
  final String pattern;

  const InterceptorPath(this.pattern, {int chainId});
}
