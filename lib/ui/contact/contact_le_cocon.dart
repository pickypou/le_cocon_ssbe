import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/common/widget/contact_card.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

class ContactLeCocon extends StatelessWidget {
  const ContactLeCocon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Image.asset(
                'assets/images/maps.png',
                fit: BoxFit.contain,
              ),
              Text(
                'Le Cocon SSBE se trouve à moins de 30 min de Lille, Lens, Henin Beaumont & Arras',
                style: textStyleText(context),
              ),
              Text(
                  'En voiture : prendre la sortie Carvin sur l\'A1 et suivre la direction d\'Annoeullin',
                  style: textStyleText(context)),
              Text(
                  'Gare la plus proche : Bauvin ( environ 900 M à pieds, 5/10 min de marche )',
                  style: textStyleText(context))
            ],
          )),
    );
  }
}
