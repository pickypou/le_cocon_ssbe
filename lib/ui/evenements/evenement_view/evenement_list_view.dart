import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/domain/entities/evenements.dart';
import 'package:le_cocon_ssbe/ui/evenements/evenement_view/evenement_view.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

class EvenementListView extends StatelessWidget {
  final List<Evenements> evenements;

  const EvenementListView({super.key, required this.evenements});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Événements',
                style: titleStyleLarge(context)
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16, // horizontal space between items
                runSpacing: 16, // vertical space between lines
                children: evenements.map((evenement) {
                  return SizedBox(
                    width: 200, // Set a fixed width for each item
                    child: EvenementView(evenement: evenement),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}