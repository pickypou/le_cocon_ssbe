import 'package:flutter/material.dart';

import '../common/widget/contact_card.dart';

class ContactSportSante extends StatelessWidget {
  const ContactSportSante({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Padding(
        padding: EdgeInsets.all(25),
        child: ContactCard(
          assetImage: 'assets/images/logo_gerard.png',
          name: 'coach sportif',
          phone: '06 27 49 07 41',
          email: 'gerard.judo.59@gmail.com',
          address: '59 rue Nationale 59185 Provin',
          website: 'gerard.fr',
          imageWidth: 220,
        ),
      ),
    );
  }
}
