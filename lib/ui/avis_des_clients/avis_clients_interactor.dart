import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../data/repository/avis_clients_repository.dart';
import '../../domain/entities/avis_clients.dart';
import '../../domain/usecases/fetch_avis_clients_data_usecase.dart';

@singleton
class AvisClientsInteractor {
  final FetchAvisClientDataUseCase fetchAvisClientDataUseCase;
  final AvisClientsRepository avisClientsRepository;

  AvisClientsInteractor(
      this.fetchAvisClientDataUseCase,
      this.avisClientsRepository,
      );

  /// Récupère les avis clients depuis le cas d'utilisation.
  Future<Iterable<AvisClients>> fetchAvisClientsData() async {
    try {
      final avisClients = await fetchAvisClientDataUseCase.getAvisClients();
      return avisClients;
    } catch (e) {
      debugPrint('Erreur lors de la récupération des avis clients : $e');
      rethrow;
    }
  }

  /// Ajoute un avis client en utilisant le repository.
  Future<void> addAvisClients(AvisClients avisClients) async {
    try {
      await avisClientsRepository.add({
        'categories': avisClients.categories,
        'text': avisClients.text,
        'firstname': avisClients.firstname,
        'publishDate': avisClients.publishDate,
      });
    } catch (error) {
      debugPrint('Erreur lors de l\'ajout de l\'avis du client : $error');
      rethrow;
    }
  }
}
