import 'package:flutter/material.dart';
import '../../../../domain/entities/avis_clients.dart';
import '../../../common/widget/bulle_avis_clients.dart';
import '../../../theme.dart';

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
              Text(
                'Les clients nous donnent leur avis',
                style: textStyleText(context),
              ),
              _buildAvisClientsBubble(context, avis.isNotEmpty ? avis[0] : null),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildAvisClientsBubble(context, avis.length > 1 ? avis[1] : null),
                  const SizedBox(width: 20),
                  _buildAvisClientsBubble(context, avis.length > 2 ? avis[2] : null),
                ],
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
      color: Theme.of(context).colorScheme.onSurface, // Utilisation du thème pour la couleur
    );
  }
}

