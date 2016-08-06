import 'package:dogma_source_analyzer/analyzer.dart';
import 'package:dogma_source_analyzer/metadata.dart';
import 'package:dogma_source_analyzer/matcher.dart';
import 'package:dogma_source_analyzer/query.dart';
import 'package:logging/logging.dart';
import 'package:greenstone/src/metadata.dart';
import 'package:greenstone/src/domain.dart' as dsl;
import 'package:greenstone/greenstone.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  scanGroups();
}
