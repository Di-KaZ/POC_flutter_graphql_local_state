import 'dart:convert';
import 'package:graphql/client.dart';
import 'package:isar/isar.dart';
part 'isar_store.g.dart';

/// FNV-1a 64bit hash algorithm optimized for Dart Strings
int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}

@collection
class GraphqlLookup {
  String? id;

  Id get isarId => fastHash(id!);

  @Ignore()
  Map<String, dynamic>? data;

  String get isarData => jsonEncode(data);

  set isarData(String json) => data = jsonDecode(json);
}

/// A [Store] implementation that uses [Isar] as the underlying storage.
class IsarStore extends Store {
  final Isar _isar;

  IsarStore(this._isar);

  @override
  void delete(String dataId) {
    _isar.writeTxnSync(() => _isar.graphqlLookups.deleteSync(fastHash(dataId)));
  }

  @override
  Map<String, dynamic>? get(String dataId) {
    return _isar.graphqlLookups.getSync(fastHash(dataId))?.data;
  }

  @override
  void put(String dataId, Map<String, dynamic>? value) {
    _isar.writeTxnSync(
      () => _isar.graphqlLookups.putSync(
        GraphqlLookup()
          ..id = dataId
          ..data = value,
      ),
    );
  }

  @override
  void putAll(Map<String, Map<String, dynamic>?> data) {
    _isar.writeTxnSync(() => _isar.graphqlLookups.putAllSync(
          data.entries
              .map(
                (e) => GraphqlLookup()
                  ..id = e.key
                  ..data = e.value,
              )
              .toList(),
        ));
  }

  @override
  void reset() {
    _isar.writeTxnSync(() => _isar.graphqlLookups.clearSync());
  }

  @override
  Map<String, Map<String, dynamic>?> toMap() {
    throw UnimplementedError();
  }
}
