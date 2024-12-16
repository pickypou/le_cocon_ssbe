import 'package:injectable/injectable.dart';
import 'package:le_cocon_ssbe/data/repository/evenement_repository_impl.dart';

import '../../data/dto/evenements_dto.dart';
import '../entities/evenements.dart';
import 'package:flutter/material.dart';

@injectable
class FetchEvenementDataUseCase {
  final EvenementRepositoryImpl evenementRepository;

  FetchEvenementDataUseCase(this.evenementRepository);

  Future<List<Evenement>> getEvenement() async {
    try {
      debugPrint("Fetching événement data from Firestore...");
      Stream<Iterable<Evenement>> evenementStream =
      evenementRepository.getEvenementStream();

      // Utilisez 'await for' pour consommer le stream
      List<Evenement> evenementList = [];
      await for (var evenementIterable in evenementStream) {
        evenementList.addAll(evenementIterable);
      }
      return evenementList;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Evenement?> getEvenementById(String evenementId) async {
    try {
      debugPrint("Fetching événement data from Firestore...");
      EvenementDto? evenementDto = await evenementRepository.getById(evenementId);
      if (evenementDto != null) {
        // Conversion de EvenementDto à Evenements
        return Evenement(
          id: evenementId,
          title: evenementDto.title,
          fileUrl: evenementDto.fileUrl,
          fileType: evenementDto.fileType,
          publishDate: evenementDto.publishDate,
        );
      } else {
        return null; // Si l'événement n'est pas trouvé
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
