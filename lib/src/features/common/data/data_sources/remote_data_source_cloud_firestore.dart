import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;
import 'remote_data_source.dart';

class RemoteDataSourceCloudFirestore implements RemoteDataSource {
  RemoteDataSourceCloudFirestore({
    cloud_firestore.FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? cloud_firestore.FirebaseFirestore.instance;

  final cloud_firestore.FirebaseFirestore _firestore;

  @override
  Future<String> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    cloud_firestore.DocumentReference<Map<String, dynamic>> ref;
    ref = await _firestore.collection(collectionPath).add(data);
    return ref.id;
  }

  @override
  Future<void> updateDocument({
    required String collectionPath,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    cloud_firestore.DocumentReference<Map<String, dynamic>> ref;
    ref = _firestore.collection(collectionPath).doc(documentId);
    await ref.update(data);
  }

  @override
  Future<List<T>> getCollection<T>({
    required String collectionPath,
    required ObjectMapper<T> objectMapper,
  }) async {
    cloud_firestore.Query<Map<String, dynamic>> query;
    query = _firestore.collection(collectionPath);

    final snapshot = await query.get();
    final result = snapshot.docs
        .map((doc) => objectMapper(doc.data(), id: doc.id))
        .where((value) => value != null)
        .toList();
    return result;
  }

  @override
  Future<T> getDocument<T>({
    required String collectionPath,
    required String documentId,
    required ObjectMapper<T> objectMapper,
  }) async {
    cloud_firestore.DocumentReference<Map<String, dynamic>> query;
    query = _firestore.collection(collectionPath).doc(documentId);

    final snapshot = await query.get();
    final result = objectMapper(snapshot.data(), id: snapshot.id);
    return result;
  }

  @override
  Stream<T?> streamDocument<T>({
    required String collectionPath,
    required String documentId,
    required ObjectMapper<T> objectMapper,
  }) {
    cloud_firestore.DocumentReference<Map<String, dynamic>> ref;
    ref = _firestore.collection(collectionPath).doc(documentId);
    final snapshots = ref.snapshots();
    final results = snapshots.map((doc) {
      if (doc.data() != null) {
        return objectMapper(doc.data()!, id: doc.id);
      } else {
        return null;
      }
    });
    return results;
  }

  @override
  Stream<List<T>> streamCollection<T>({
    required String collectionPath,
    required ObjectMapper<T> objectMapper,
    String? field,
    dynamic isEqualToValue,
    dynamic arrayContainsValue,
  }) {
    cloud_firestore.Query<Map<String, dynamic>> query;
    query = _firestore.collection(collectionPath);

    if (field != null) {
      query = query.where(
        field,
        isEqualTo: isEqualToValue,
        arrayContains: arrayContainsValue,
      );
    }

    final snapshots = query.snapshots();
    final results = snapshots.map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return <T>[];
      } else {
        return snapshot.docs
            .map((doc) => objectMapper(doc.data(), id: doc.id))
            .toList();
      }
    });
    return results;
  }
}
