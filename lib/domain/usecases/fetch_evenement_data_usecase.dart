import 'package:injectable/injectable.dart';

import '../../data/dto/evenements_dto.dart';
import '../../data/repository/evenements_repository.dart';
import '../entities/evenements.dart';
import 'package:flutter/material.dart';

@injectable
class FetchEvenementDataUseCase {
  final EvenementRepository evenementRepository;

  FetchEvenementDataUseCase(this.evenementRepository);

  Future<List<Evenements>> getEvenement() async {
    try {
      debugPrint("Fetching événement data from Firestore...");
      Stream<Iterable<Evenements>> evenementStream =
      evenementRepository.getEvenementStream();

      // Utilisez 'await for' pour consommer le stream
      List<Evenements> evenementList = [];
      await for (var evenementIterable in evenementStream) {
        evenementList.addAll(evenementIterable);
      }
      return evenementList;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Evenements?> getEvenementById(String evenementId) async {
    try {
      debugPrint("Fetching événement data from Firestore...");
      EvenementDto? evenementDto = await evenementRepository.getById(evenementId);
      if (evenementDto != null) {
        // Conversion de EvenementDto à Evenements
        return Evenements(
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
