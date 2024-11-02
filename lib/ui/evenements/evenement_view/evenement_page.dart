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
          .limit(5)
          .snapshots(),
      builder: (context, snapshot) {
        // Gestion de l'état de connexion
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Gestion des erreurs
        if (snapshot.hasError) {
          debugPrint("Erreur lors de la récupération des données : ${snapshot.error}");
          return Center(child: Text('Erreur : ${snapshot.error}'));
        }

        // Gestion des données vides
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          debugPrint("Aucune donnée disponible dans la collection 'evenement'");
          return const Center(child: Text('Aucun événement disponible'));
        }

        // Transformation des données
        List<Evenements> evenement = snapshot.data!.docs
            .map((doc) {
          try {
            return Evenements.fromMap(
              doc.data() as Map<String, dynamic>,
              doc.id,
            );
          } catch (e) {
            debugPrint("Erreur lors de la transformation des données : $e");
            return null; // Gérer la transformation échouée
          }
        })
            .where((event) => event != null) // Éliminer les éléments nuls
            .cast<Evenements>() // Cast pour le type correct
            .toList();

        debugPrint("Données récupérées : $evenement");

        // Utilisation de EvenementListView pour afficher les événements
        return EvenementListView(evenement: evenement); // Transmettre les données récupérées
      },
    );
  }
}
