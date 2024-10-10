import 'package:flutter/material.dart';

import '../common/widget/contact_card.dart';

class ContactBientEtre extends StatelessWidget {
  const ContactBientEtre({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: ContactCard(
          assetImage: 'assets/images/logo_loren.png',
          name: 'au coeur de l\'e-sens-ciel',
          phone: '06 78 44 30 57',
          email: 'aucoeordelesensciel@gmail.com',
          address: '59 rue Nationale 59185 Provin',
          website: 'https://www.aucoeurdelesensciel.com',
        ),
      ),
    );
  }
}
