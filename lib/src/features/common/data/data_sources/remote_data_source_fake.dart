import 'remote_data_source.dart';

class RemoteDataSourceFake implements RemoteDataSource {
  @override
  Future<String> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) {
    // TODO: implement addDocument
    throw UnimplementedError();
  }

  @override
  Future<void> updateDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) {
    // TODO: implement updateDocument
    throw UnimplementedError();
  }

  @override
  Future<T> getDocument<T>({
    required String collectionPath,
    required String documentId,
    required ObjectMapper<T> objectMapper,
  }) async {
    final snapshot =
        _remoteDataSourceFakeData[collectionPath]?[documentId] ?? {};
    final result = objectMapper(snapshot, id: documentId);
    return result;
  }

  @override
  Future<List<T>> getCollection<T>({
    required String collectionPath,
    required ObjectMapper<T> objectMapper,
  }) async {
    final snapshot =
        _remoteDataSourceFakeData[collectionPath] as Map<String, dynamic>;
    final result = snapshot.entries
        .map((doc) => objectMapper(doc.value, id: doc.key))
        .where((value) => value != null)
        .toList();
    return result;
  }

  @override
  Stream<List<T>> streamCollection<T>({
    required String collectionPath,
    required ObjectMapper<T> objectMapper,
    required String field,
    dynamic isEqualToValue,
    dynamic arrayContainsValue,
  }) {
    // TODO: implement streamCollection
    throw UnimplementedError();
  }

  @override
  Stream<T?> streamDocument<T>({
    required String collectionPath,
    required String documentId,
    required ObjectMapper<T> objectMapper,
  }) {
    // TODO: implement streamDocument
    throw UnimplementedError();
  }
}

const _remoteDataSourceFakeData = {
  'posts': {
    'id_1': {
      'caption': 'caption_1',
      'imageUrl':
          'https://images.unsplash.com/photo-1684076863982-8493240cd49b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1287&q=80',
      'createdAt': null, //'2023-01-01T00:00:00.000Z',
    },
    'id_2': {
      'caption': 'caption_2',
      'imageUrl':
          'https://images.unsplash.com/photo-1684230413575-f83bf3acddb7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1285&q=80',
      'createdAt': '2023-01-01T00:00:00.000Z',
    },
  }
};
