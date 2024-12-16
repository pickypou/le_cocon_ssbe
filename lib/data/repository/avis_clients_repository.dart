
import '../../domain/entities/avis_clients.dart';


abstract class AvisClientsRepository {
  Stream<Iterable<AvisClients>> getAvisClientsStream();
  Future<Map<String, dynamic>> getById(String avisClientsId);
  Future<void> add(Map<String, dynamic> data);
  Future<void>updateField(
      String avisClientsId, String fieldName, String newValue);
}

