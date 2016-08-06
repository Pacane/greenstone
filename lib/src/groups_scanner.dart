import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/query.dart';
import 'domain.dart' as dsl;
import 'metadata.dart';

void validateGroupMetadata(ClassMetadata m) {}

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
    print(group);
  });
}
