class queryParam {
  final String name;

  const queryParam(this.name);
}

class bodyParam {
  final String name;

  const bodyParam(this.name);
}

class post {
  const post();
}

class produces {
  const produces.json();
  const produces.stream();
  const produces.string();
}

class consumes {
  const consumes.json();
}

