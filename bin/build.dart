import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/query.dart';
import 'package:logging/logging.dart';
import 'package:greenstone/src/metadata.dart';
import 'package:greenstone/src/domain.dart' as dsl;

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  final context = analysisContext();
  var library = libraryMetadata(
      Uri.parse('package:greenstone/resources.dart'), context,
      annotationCreators: [
        analyzeAnnotation('Group'),
        analyzeAnnotation('Get'),
        analyzeAnnotation('Post'),
        analyzeAnnotation('QueryParam'),
      ]);

  final groupSymbols = libraryMetadataQueryAll/*<ClassMetadata>*/(
          library, (ClassMetadata m) => m.annotations.any((a) => a is Group),
          includeClasses: true)
      .toList();

  groupSymbols.forEach((ClassMetadata classMetaData) {
    validateGroupMetadata(classMetaData);

    final groupAnnotation =
        classMetaData.annotations.singleWhere((a) => a is Group) as Group;

    final group = new dsl.Group()..path = groupAnnotation.path;


    final b = 12;
  });


  print("allo");
}

void validateGroupMetadata(ClassMetadata m) {}

class MetadataValidationException implements Exception {
  const MetadataValidationException(String message);
}
