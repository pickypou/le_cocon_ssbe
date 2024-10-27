import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/evenements/evenement_view/evenement_list_view.dart';

import '../../../domain/entities/evenements.dart';

class EvenementPage extends StatelessWidget {
  const EvenementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('evenement')
          .orderBy('publishDate', descending: true)
          .limit(3)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print("Erreur lors de la récupération des données : ${snapshot.error}");
          return Center(child: Text('Erreur : ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          print("Aucune donnée disponible dans la collection 'evenement'");
          return const Center(child: Text('Aucun événement disponible'));
        }

        // Transformation des données
        List<Evenements> evenement = snapshot.data!.docs
            .map((doc) => Evenements.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        ))
            .toList();

        print("Données récupérées : $evenement");

        // Utilisation de EvenementListView pour afficher les événements
        return EvenementListView(evenement: evenement); // Transmettre les données récupérées
      },
    );
  }
}
