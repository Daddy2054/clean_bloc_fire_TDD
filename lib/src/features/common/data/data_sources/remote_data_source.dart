typedef ObjectMapper<T> = T Function(Map<String, dynamic>? data, {String? id});

abstract class RemoteDataSource {
  Future<String> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  });
  Future<void> updateDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  });
    Future<void> updateDocumentList({
    required String collectionPath,
    required String documentId,
    required String field,
    required dynamic value,
  });
  Future<List<T>> getCollection<T>({
    required String collectionPath,
    required ObjectMapper<T> objectMapper,
  });
  Future<T?> getDocument<T>({
    required String collectionPath,
    required String documentId,
    required ObjectMapper<T> objectMapper,
  });
  Stream<T?> streamDocument<T>({
    required String collectionPath,
    required String documentId,
    required ObjectMapper<T> objectMapper,
  });
  Stream<List<T>> streamCollection<T>({
    required String collectionPath,
    required ObjectMapper<T> objectMapper,
    required String field,
    dynamic isEqualToValue,
    dynamic arrayContainsValue,
  });
}
