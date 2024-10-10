import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/data/domain/entities/avis_clients/avis_clients.dart';
import 'package:le_cocon_ssbe/ui/common/widget/bulle_avis_clients.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

class RecupAvisClients extends StatelessWidget {
  final AvisClients avis;

  const RecupAvisClients({Key? key, required this.avis}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BulleAvisClients(
      date: avis.formattedPublishDate,
      categories: avis.categories,
      text: avis.text,
      color: theme.colorScheme.onSurface,
    );
  }
}