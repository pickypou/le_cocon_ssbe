import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/evenements.dart';

class EvenementPage {
  Future<List<Evenements>> fetchEvenements() async {
    List<Evenements> evenements = [];
    Set<String> seenEventIds = {};

    try {
      // Récupérer les événements depuis Firestore
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('evenements')
          .orderBy('publishDate', descending: true)
          .get();

      for (var doc in snapshot.docs) {
        Evenements evt =
            Evenements.fromMap(doc.data() as Map<String, dynamic>, doc.id);

        if (seenEventIds.contains(evt.id)) continue; // Eviter les doublons
        seenEventIds.add(evt.id);

        try {
          // Références des fichiers dans Firebase Storage
          final fileRef = FirebaseStorage.instance
              .ref()
              .child('evenement/${evt.id}/file.pdf');
          final imageRef = FirebaseStorage.instance
              .ref()
              .child('evenement/${evt.id}/file.jpg'); // ou .png ou autre
          final thumbnailRef = FirebaseStorage.instance
              .ref()
              .child('evenement/${evt.id}/thumbnail.jpg');

          // Vérifie si le fichier PDF existe
          try {
            evt.fileUrl = await fileRef.getDownloadURL();
            evt.fileType = 'pdf'; // Type PDF
            try {
              evt.thumbnailUrl =
                  await thumbnailRef.getDownloadURL(); // Thumbnail pour PDF
            } catch (e) {
              debugPrint(
                  "Aucune vignette trouvée pour l'événement ${evt.id} (PDF)");
            }
          } catch (e) {
            // Si le PDF n'est pas trouvé, on vérifie si c'est une image
            try {
              evt.fileUrl = await imageRef.getDownloadURL();
              evt.fileType = 'image'; // Type image
              evt.thumbnailUrl = evt.fileUrl; // Utilise l'image comme vignette
            } catch (e) {
              debugPrint("Aucun fichier trouvé pour l'événement ${evt.id}");
            }
          }

          debugPrint(
              'Fichier récupéré pour l\'événement ${evt.id}: ${evt.fileUrl}');
          debugPrint(
              'Type de fichier pour l\'événement ${evt.id}: ${evt.fileType}');

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
