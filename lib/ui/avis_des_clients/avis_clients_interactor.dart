import 'package:flutter/material.dart';

import '../../core/di/di.dart';
import '../../data/repository/avis_client_repositoryImpl.dart';
import '../../data/repository/avis_clients_repository.dart';
import '../../domain/entities/avis_clients.dart';
import '../../domain/usecases/fetch_avis_clients_data_usecase.dart';


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

}