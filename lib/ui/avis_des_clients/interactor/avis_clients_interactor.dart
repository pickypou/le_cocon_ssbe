import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/data/domain/entities/avis_clients/avis_clients.dart';
import 'package:le_cocon_ssbe/data/domain/usecases/avis_clients/fetch_avis_clients_data_usecase.dart';
import 'package:le_cocon_ssbe/data/repository/avis_clients_repository/avis_clients_repository.dart';



class AvisClientsInteractor {
  final FetchAvisClientDataUseCase fetchAvisClientDataUseCase;
  final AvisClientsRepository avisClientsRepository;

  AvisClientsInteractor(
      this.avisClientsRepository, this.fetchAvisClientDataUseCase
      );
  Future<Iterable<AvisClients>> fetchAvisClientsData() async {
    try {
      final avisClients = await fetchAvisClientDataUseCase.getAvisClients();
      return avisClients;
    }catch(e) {
      debugPrint('Erreur lors du récupération des avis clients : $e');
      rethrow;
    }
  }
  Future<void> addAvisClients(AvisClients avisClients) async {
    try {
      await avisClientsRepository.add({
        'categories': avisClients.categories,
        'text': avisClients.text,
        'publishDate': avisClients.publishDate
      });
    } catch (error) {
      debugPrint('Erreur lors de l\'ajout de l\'avis du client: $error');
      rethrow;
    }
  }

}