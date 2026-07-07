import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutorial_management/core/firebase/firebase_logger.dart';
import 'package:tutorial_management/core/firebase/firebase_exception_mapper.dart';

/// Decoupled wrapper client for performing Firestore operations.
class FirestoreClient {
  final FirebaseFirestore _firestore;
  final FirebaseLogger _logger;

  FirestoreClient(this._firestore, this._logger);

  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> data) fromJson,
  }) async {
    try {
      _logger.log('Reading document: $path');
      final doc = await _firestore.doc(path).get();
      if (!doc.exists) {
        throw FirebaseException(plugin: 'Firestore', code: 'not-found');
      }
      return fromJson(doc.data()!);
    } on FirebaseException catch (e) {
      _logger.logError('Failed reading document at $path: ${e.message}');
      throw FirebaseExceptionMapper.mapToException(e);
    }
  }

  Future<void> setDocument({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    try {
      _logger.log('Writing document: $path');
      await _firestore.doc(path).set(data);
    } on FirebaseException catch (e) {
      _logger.logError('Failed writing document at $path: ${e.message}');
      throw FirebaseExceptionMapper.mapToException(e);
    }
  }

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data) fromJson,
  }) async {
    try {
      _logger.log('Reading collection: $path');
      final querySnapshot = await _firestore.collection(path).get();
      return querySnapshot.docs.map((doc) => fromJson(doc.data())).toList();
    } on FirebaseException catch (e) {
      _logger.logError('Failed reading collection at $path: ${e.message}');
      throw FirebaseExceptionMapper.mapToException(e);
    }
  }
}
