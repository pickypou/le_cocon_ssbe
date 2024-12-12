import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../core/di/di.dart';
import '../../data/repository/avis_client_repository_impl.dart';
import '../../data/repository/avis_clients_repository.dart';
import '../../domain/entities/avis_clients.dart';
import '../../domain/usecases/fetch_avis_clients_data_usecase.dart';

@singleton
class AvisClientsInteractor {
  final FetchAvisClientDataUseCase fetchAvisClientDataUseCase = getIt<FetchAvisClientDataUseCase>();
  final AvisClientsRepository avisClientsRepository = getIt<AvisClientsRepositoryImpl>() ;


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
        'firstname': avisClients.firstname,
        'publishDate': avisClients.publishDate
      });
    } catch (error) {
      debugPrint('Erreur lors de l\'ajout de l\'avis du client: $error');
      rethrow;
    }
  }

}