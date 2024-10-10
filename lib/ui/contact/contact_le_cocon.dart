import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:le_cocon_ssbe/ui/common/widget/contact_card.dart';

class ContactLeCocon extends StatelessWidget {
  const ContactLeCocon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: ContactCard(
          assetImage: 'assets/images/logo_cocon.png',
          name: 'Le cocon ssbe',
          phone: '06 78 44 30 57',
          email: 'lecoconssbe@gmail.com',
          address: '59 rue Nationale 59185 Provin',
          website: 'https://lecoconssbe.fr/',
         // location: LatLng(50.5125894,2.9132476),
        ),
      ),
    );
  }
}
