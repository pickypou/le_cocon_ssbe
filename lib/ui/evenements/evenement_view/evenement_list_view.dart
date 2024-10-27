import 'package:flutter/material.dart';
import '../../../domain/entities/evenements.dart';
import '../../theme.dart';

class EvenementListView extends StatelessWidget {
  final List<Evenements> evenement;

  const EvenementListView({super.key, required this.evenement});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Définissez une hauteur appropriée
      child: ListView.builder(
        itemCount: evenement.length,
        itemBuilder: (context, index) {
          final evt = evenement[index];
          return Card(
            child: ListTile(
              title: Text(evt.title),
              subtitle: Text(evt.formattedPublishDate),
              leading: Image.network(evt.fileUrl, width: 50, height: 50, fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
