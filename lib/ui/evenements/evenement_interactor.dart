import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/domain/entities/evenements.dart';
import 'package:le_cocon_ssbe/domain/usecases/fetch_evenement_data_usecase.dart';
import '../../core/di/di.dart';

class EvenementInteractor {
  final FetchEvenementDataUseCase fetchEvenementDataUseCase =
  getIt<FetchEvenementDataUseCase>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<List<Evenement>> fetchEvenements() async {
    List<Evenement> evenements = [];
    Set<String> seenEventIds = {};

    try {
      QuerySnapshot snapshot = await _firestore
          .collection('evenement')
          .orderBy('publishDate', descending: true)
          .get();

      for (var doc in snapshot.docs) {
        Evenement evt = Evenement.fromMap(
            doc.data() as Map<String, dynamic>, doc.id);

        if (seenEventIds.contains(evt.id)) continue;

        seenEventIds.add(evt.id);

        // Récupération du fichier et de la vignette
        try {
          final fileRef = _firebaseStorage.ref().child('evenement/${evt.id}/file.pdf');
          final imageRef = _firebaseStorage.ref().child('evenement/${evt.id}/file.jpg');
          final thumbnailRef = _firebaseStorage.ref().child('evenement/${evt.id}/thumbnail.jpg');

          try {
            // Si c'est un fichier PDF
            evt.fileUrl = await fileRef.getDownloadURL();
            evt.fileType = 'pdf';

            try {
              // Récupérer la vignette
              evt.thumbnailUrl = await thumbnailRef.getDownloadURL();
            } catch (e) {
              debugPrint("Aucune vignette trouvée pour l'événement ${evt.id}");
              evt.thumbnailUrl = null; // Pas de vignette pour ce PDF
            }
          } catch (e) {
            // Si c'est une image
            try {
              evt.fileUrl = await imageRef.getDownloadURL(); // Récupère l'image
              evt.fileType = 'image';
              evt.thumbnailUrl = evt.fileUrl; // Utilise l'image comme vignette si elle existe
            } catch (e) {
              debugPrint("Aucun fichier trouvé pour l'événement ${evt.id}");
            }
          }

          evenements.add(evt);
        } catch (e) {
          debugPrint('Erreur lors de la récupération des fichiers pour l\'événement ${evt.id}: $e');
        }
      }
    } catch (e) {
      debugPrint("Erreur lors de la récupération des événements : $e");
      rethrow;
    }

    return evenements;
  }

  Future<Evenement?> fetchEvenementById(String evenementId) async {
    try {
      final evenement = await fetchEvenementDataUseCase.getEvenementById(evenementId);
      return evenement;
    } catch (e) {
      debugPrint('Erreur lors de la récupération de l\'événement spécifique : $e');
      rethrow;
    }
  }
}
