import 'package:build/build.dart';
import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/query.dart';
import 'package:logging/logging.dart';

main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  final context = analysisContext();
  var library =
      libraryMetadata(Uri.parse('package:greenstone/resources.dart'), context);

  var classQuery = libraryMetadataQueryAll(library, (value) => true,
      includeClasses: true,
      includeExports: true,
      includeFields: true,
      includeFunctions: true,
      includeImports: true);

  var b = classQuery.toList();
  print("allo");
}
