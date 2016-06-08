import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/query.dart';
import 'package:logging/logging.dart';
import 'package:greenstone/metadata.dart';

main() {
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

  final groups = libraryMetadataQueryAll/*<ClassMetadata>*/(
          library, (ClassMetadata m) => m.annotations.any((a) => a is Group),
          includeClasses: true)
      .toList();

  

  groups.forEach((ClassMetadata m) {

  });

  final postEndpoints = groups.where((MethodMetadata e) => e.annotations.any((a) => a is Post));
  final getEndpoints = groups.where((MethodMetadata e) => e.annotations.any((a) => a is Get));



  print("allo");
}
