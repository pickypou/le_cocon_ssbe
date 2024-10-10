import 'package:flutter/foundation.dart';
import 'package:le_cocon_ssbe/data/domain/entities/avis_clients/avis_clients.dart';
import 'package:le_cocon_ssbe/data/repository/avis_clients_repository/avis_clients_repository.dart';

class FetchAvisClientDataUseCase {
  final AvisClientsRepository avisClientsRepository;

  FetchAvisClientDataUseCase(this.avisClientsRepository);

  Future<List<AvisClients>> getAvisClients() async {
    try {
      debugPrint("Fetching avis_client data from Firestore...");
      Stream<Iterable<AvisClients>> avisClientStream =
          avisClientsRepository.getAvisClientsStream();

      //Utilisez 'await for' pour consommer le stream
      List<AvisClients> avisClientsList = [];
      await for (var avisClientsIterable in avisClientStream) {
        avisClientsList.addAll(avisClientsIterable);
      }
      return avisClientsList;
    }catch(e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<AvisClients?> getAvisClientsById(String avisClientsId) async {
    try {
      debugPrint("Fetching avis_client data from Firestore...");
      Map<String, dynamic>? avisClientsData =
          await avisClientsRepository.getById(avisClientsId);
      return AvisClients.fromMap(avisClientsData, avisClientsId);
    }catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}