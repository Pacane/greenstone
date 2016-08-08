library simple_resource;

import 'package:greenstone/greenstone.dart';

@Group('/hello')
class SimpleResource {
  @Get('/world')
  Response getSomeObject() {
    return new Response.ok('Hello World');
  }

  @Get('/double-value')
  Response withSomeQueryParams(@QueryParam() int a) {
    return new Response.ok((a * 2).toString());
  }

  @Post('/save')
  Response withBodyParam(@BodyParam(json) Map p) {
    return new Response.ok('Ok!');
  }
}
