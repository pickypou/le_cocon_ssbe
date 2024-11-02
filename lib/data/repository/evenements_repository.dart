

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/evenements.dart';

abstract class EvenementRepository {
  FirebaseFirestore get firestore;

  Stream<Iterable<Evenements>> getEvenementStream();
  Future<Map<String, dynamic>?>getById(String evenementId);
}