import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/common/widget/text_custom.dart';

import '../../../../domain/entities/avis_clients.dart';
import '../../../common/widget/bulle_avis_clients.dart';

class AvisClientsListView extends StatelessWidget {
  final List<AvisClients> avis;

  const AvisClientsListView({super.key, required this.avis});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                phrase: 'Les, Clients, Nous, Donnent, Leurs, Avis',
              ),
              const SizedBox(
                  height: 16), // Espacement entre le texte et les avis
              Wrap(
                spacing: 20, // Espace horizontal entre les éléments
                runSpacing: 20, // Espace vertical entre les lignes
                alignment: WrapAlignment.start, // Aligner les éléments à gauche
                children: avis.map((avisClient) {
                  return SizedBox(
                    width:
                        (constraints.maxWidth - 60) / 3, // 3 bulles par ligne
                    child: _buildAvisClientsBubble(context, avisClient),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAvisClientsBubble(BuildContext context, AvisClients? avis) {
    if (avis == null) {
      return const SizedBox(); // Si aucun avis n'est disponible, renvoie une boîte vide
    }

    return BulleAvisClients(
      date: avis.formattedPublishDate,
      categories: avis.categories,
      text: avis.text,
      color: Theme.of(context)
          .colorScheme
          .onSurface, // Utilisation du thème pour la couleur
    );
  }
}
