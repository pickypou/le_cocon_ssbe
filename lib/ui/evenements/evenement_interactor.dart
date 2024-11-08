import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/domain/entities/evenements.dart';
import 'package:le_cocon_ssbe/domain/usecases/fetch_evenement_data_usecase.dart';
import '../../core/di/di.dart';

class EvenementInteractor {
  final FetchEvenementDataUseCase fetchEvenementDataUseCase =
  getIt<FetchEvenementDataUseCase>();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // L'Interactor n'a pas besoin d'injecter un repository ici, on utilise directement le UseCase
  // final EvenementRepository evenementRepository = getIt<EvenementRepositoryImpl>();

  Future<Iterable<Evenements>> fetchEvenementData() async {
    try {
      final evenement = await fetchEvenementDataUseCase.getEvenement();
      return evenement;
    } catch (e) {
      debugPrint('Erreur lors de la récupération des événements : $e');
      rethrow;  // L'erreur est renvoyée pour pouvoir la capturer dans le bloc
    }
  }

  Future<Evenements?> fetchEvenementById(String evenementId) async {
    try {
      final evenement = await fetchEvenementDataUseCase.getEvenementById(evenementId);
      return evenement;
    } catch (e) {
      debugPrint('Erreur lors de la récupération de l\'événement spécifique : $e');
      rethrow;
    }
  }
// Récupération des événements depuis Firestore et les fichiers associés
  Future<List<Evenements>> fetchEvenement() async {
    List<Evenements> evenements = [];
    Set<String> seenEventIds = {};

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('evenements')
          .orderBy('publishDate', descending: true)
          .get();

      for (var doc in snapshot.docs) {
        Evenements evt = Evenements.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);

        if (seenEventIds.contains(evt.id)) {
          continue;
        }
        seenEventIds.add(evt.id);

        try {
          final fileRef = _firebaseStorage.ref().child(
              'evenement/${evt.id}/file.pdf');
          final thumbnailRef = _firebaseStorage.ref().child(
              'evenement/${evt.id}/thumbnail.jpg');

          String fileUrl = await fileRef.getDownloadURL();
          String thumbnailUrl = await thumbnailRef.getDownloadURL();

          evt.fileUrl = fileUrl;
          evt.thumbnailUrl = thumbnailUrl;

          debugPrint(
              'Fichier PDF récupéré pour l\'événement ${evt.id}: $fileUrl');
          debugPrint(
              'Vignette récupérée pour l\'événement ${evt.id}: $thumbnailUrl');

          evenements.add(evt);
        } catch (e) {
          debugPrint(
              'Erreur lors de la récupération des fichiers pour l\'événement ${evt.id}: $e');
        }
      }
    } catch (e) {
      debugPrint("Erreur lors de la récupération des événements : $e");
    }

    return evenements;
  }
}
