import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:le_cocon_ssbe/ui/avis_des_clients/view/avis_client_list_view.dart';
import 'package:le_cocon_ssbe/ui/common/widget/custom_button.dart';

import '../../domain/entities/avis_clients.dart';
import '../common/widget/text_custom.dart';

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

        // Log pour vérifier les données
        debugPrint('Nombre d\'avis : ${avis.length}');
        for (var avisItem in avis) {
          debugPrint('Avis : ${avisItem.text}');
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
              phrase: 'Les, Clients, Nous, Donnent, Leurs, Avis',
            ),
            AvisClientsListView(
              avis: avis,
              backgroundImage: 'assets/images/facade_cocon.jpeg',
            ),
            const SizedBox(height: 35),
            CustomButton(
              label: 'Je donne mon avis',
              onPressed: () => GoRouter.of(context).go('/addAvisClients'),
            ),
          ],
        );
      },
    );
  }
}

