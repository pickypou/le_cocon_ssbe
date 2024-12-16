import 'package:injectable/injectable.dart';

import '../../core/di/api/firestore_service.dart';
import '../../domain/entities/avis_clients.dart';
import 'avis_clients_repository.dart';


@Injectable(as: AvisClientsRepository)
class AvisClientsRepositoryImpl extends AvisClientsRepository {
  final FirestoreService _firestore;

  AvisClientsRepositoryImpl(this._firestore);

  @override
  Stream<Iterable<AvisClients>> getAvisClientsStream() {
    return _firestore.collection('avis_clients').snapshots().map(
          (querySnapshot) => querySnapshot.docs
          .map((doc) => AvisClients.fromMap(doc.data() as Map<String, dynamic>?, doc.id))
          .toList(),
    );
  }

  @override
  Future<Map<String, dynamic>> getById(String avisClientsId) async {
    final docSnapshot =
    await _firestore.collection('avis_client').doc(avisClientsId).get();
    return docSnapshot.data() as Map<String, dynamic>? ?? {};
  }

  @override
  Future<void> add(Map<String, dynamic> data) async {
    await _firestore.collection('avis_clients').add(data);
  }

  @override
  Future<void> updateField(
      String avisClientsId, String fieldName, String newValue) async {
    await _firestore
        .collection('avis_client')
        .doc(avisClientsId)
        .update({fieldName: newValue});
  }
}
