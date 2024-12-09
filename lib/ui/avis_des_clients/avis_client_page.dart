import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/avis_clients.dart';
import '../common/widget/text_custom.dart';
import 'avis_clients_list/view/avis_client_list_view.dart';

class AvisClientsPage extends StatelessWidget {
  const AvisClientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('avis_clients')
          .orderBy('publishDate', descending: true)
          .limit(15)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Aucun avis disponible'));
        }

        // Transformation des données
        List<AvisClients> avis = snapshot.data!.docs
            .map((doc) => AvisClients.fromMap(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ))
            .toList();

        // Utilisation de AvisClientsListView pour afficher les avis
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              phrase: 'Les, Clients, Nous, Donnent, Leurs, Avis',
            ),
            AvisClientsListView(
              avis: avis,
              backgroundImage: 'assets/images/facade_cocon.jpeg',
            )
          ],
        );
      },
    );
  }
}
