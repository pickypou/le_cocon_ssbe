import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:le_cocon_ssbe/data/repository/enements_repository.dart';
import 'package:le_cocon_ssbe/domain/entities/evenements.dart';

@injectable
class FetchEvenementDataUseCase {
  final EvenementRepository evenementRepository;

  FetchEvenementDataUseCase(this.evenementRepository);

  Future<List<Evenements>> getEvenement() async {
    try {
      debugPrint("Fetching avis_client data from Firestore...");
      Stream<Iterable<Evenements>> evenementStream =
          evenementRepository.getEvenementStream();

      //Utilisez 'await for' pour consommer le stream
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
      debugPrint("Fetching avis_client data from Firestore...");
      Map<String, dynamic>? evenementData =
          await evenementRepository.getById(evenementId);
      return Evenements.fromMap(evenementData, evenementId);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
