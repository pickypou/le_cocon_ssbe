import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/data/repository/evenements_repository.dart';
import 'package:le_cocon_ssbe/data/repository/evenement_repository_impl.dart';
import 'package:le_cocon_ssbe/domain/entities/evenements.dart';
import 'package:le_cocon_ssbe/domain/usecases/fetch_evenement_data_usecase.dart';

import '../../core/di/di.dart';

class EvenementInteractor {
  final FetchEvenementDataUseCase fetchEvenementDataUseCase =
      getIt<FetchEvenementDataUseCase>();
  final EvenementRepository avisClientsRepository =
      getIt<EvenementRepositoryImpl>();

  Future<Iterable<Evenements>> fetchEvenementData() async {
    try {
      final evenement = await fetchEvenementDataUseCase.getEvenement();
      return evenement;
    } catch (e) {
      debugPrint('Erreur lors du récupération de l\'evenement : $e');
      rethrow;
    }
  }
}
