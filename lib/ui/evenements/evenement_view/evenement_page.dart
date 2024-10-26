import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/domain/entities/evenements.dart';

import 'evenement_list_view.dart';

class EvenementPage extends StatelessWidget {
  const EvenementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('evenement')
          .orderBy('publishDate', descending: true)
          .limit(8)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Aucun événement disponible'));
        }

        // Transformation des données
        List<Evenements> evenement = snapshot.data!.docs
            .map((doc) => Evenements.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        ))
            .toList();

        // Utilisation de AvisClientsListView pour afficher les avis
        return const EvenementListView( evenements: [],);
      },
    );
  }
}

