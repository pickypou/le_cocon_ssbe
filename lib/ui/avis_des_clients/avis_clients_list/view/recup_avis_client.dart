import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/data/domain/entities/avis_clients/avis_clients.dart';
import 'package:le_cocon_ssbe/ui/common/widget/bulle_avis_clients.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

class RecupAvisClients extends StatelessWidget {
  final AvisClients avis;

  const RecupAvisClients({super.key, required this.avis});

  @override
  Widget build(BuildContext context) {
    return BulleAvisClients(
      date: avis.formattedPublishDate,
      categories: avis.categories,
      text: avis.text,
      color: theme.colorScheme.onSurface,
    );
  }
}
