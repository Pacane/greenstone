import 'package:build_runner/build_runner.dart';
import 'package:greenstone/greenstone.dart';
import 'package:source_gen/source_gen.dart';

final PhaseGroup phases = new PhaseGroup.singleAction(
    new GeneratorBuilder(const [const SomeGenerator()]),
    new InputSet('greenstone', const ['test/test_cases/simple_resource.dart']));
