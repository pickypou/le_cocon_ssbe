import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../../domain/entities/evenements.dart';
import 'package:flutter/material.dart';

class EvenementPage {
  // Récupération des événements depuis Firestore
  Future<List<Evenements>> fetchEvenements() async {
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
          final fileRef = FirebaseStorage.instance.ref().child(
              'evenement/${evt.id}/file.pdf');
          final thumbnailRef = FirebaseStorage.instance.ref().child(
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
              'Erreur lors de la récupération des fichiers pour l\'événement ${evt
                  .id}: $e');
        }
      }
    } catch (e) {
      debugPrint("Erreur lors de la récupération des événements : $e");
    }

    return evenements;
  }}