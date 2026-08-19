import 'package:flutter_test/flutter_test.dart';
import 'package:phrasepal/data/phrase_catalog.dart';

void main() {
  test('Japanese airport phrases are bundled', () {
    final list = PhraseCatalog.forLanguage('ja', extra: false);
    expect(list.where((p) => p.categoryId == 'airport').length, greaterThanOrEqualTo(5));
    expect(list.any((p) => p.english.contains('boarding pass')), isTrue);
  });

  test('Vietnamese and Chinese packs are bundled', () {
    expect(PhraseCatalog.forLanguage('vi', extra: true).length, greaterThanOrEqualTo(30));
    expect(PhraseCatalog.forLanguage('zh', extra: true).any((p) => p.native.contains('登机')), isTrue);
  });
}
