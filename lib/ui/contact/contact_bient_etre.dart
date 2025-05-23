import 'package:flutter/material.dart';

import '../common/widget/contact_card.dart';

class ContactBientEtre extends StatelessWidget {
  const ContactBientEtre({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ContactCard(
          assetImage: 'assets/images/logo_loren.png',
          name: 'Au Coeur de l\'E-Sens-Ciel',
          phone: '06 78 44 30 57',
          email: 'aucoeurdelesensciel@gmail.com',
          address: '59 rue Nationale 59185 Provin',
          website: 'https://www.aucoeurdelesensciel.com',
          imageHeight: 100,
          imageWidth: 100,
        ),
      ),
    );
  }
}
