import 'dart:async';
import 'package:build_runner/build_runner.dart';

import 'phases.dart';

Future<Null> main() async {
  await build(phases, deleteFilesByDefault: true);
}
