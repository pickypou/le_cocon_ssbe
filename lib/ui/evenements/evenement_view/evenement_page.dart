import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/evenements.dart';
import 'evenement_list_view.dart';

class EvenementPage extends StatelessWidget {
  const EvenementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('evenement')
          .orderBy('publishDate', descending: true)
          .limit(5)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          debugPrint("Erreur lors de la récupération des données : ${snapshot.error}");
          return Center(child: Text('Erreur : ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          debugPrint("Aucune donnée disponible dans la collection 'evenement'");
          return const Center(child: Text('Aucun événement disponible'));
        }

        List<Evenements> evenement = snapshot.data!.docs
            .map((doc) {
          try {
            return Evenements.fromMap(
              doc.data() as Map<String, dynamic>,
              doc.id,
            );
          } catch (e) {
            debugPrint("Erreur lors de la transformation des données : $e");
            return null;
          }
        })
            .where((event) => event != null)
            .cast<Evenements>()
            .toList();

        debugPrint("Données récupérées : $evenement");

        return EvenementListView(evenement: evenement);
      },
    );
  }
}
