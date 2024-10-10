import 'package:flutter/material.dart';

import '../common/widget/activities.dart';

class ActivityBienEtre extends StatelessWidget {
  const ActivityBienEtre({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Activities(
            title: 'Des soin énergétiques',
            text: '',
            value: 'tete.png',
            isImageBeforeTitle: false, logo: 'petit_logo_loren.png',
          ),
          Activities(
            value: 'palmaire.jpg',
            title: 'Divers massages',
            text: '',
            isImageBeforeTitle: true, logo: 'petit_logo_loren.png',
          ),
          Activities(
            value: 'img_header_1.jpeg',
            title: 'Du magnétisme',
            text: '',
            isImageBeforeTitle: false, logo: 'petit_logo_loren.png',),
          Activities(
            value: 'bol_tibetains.jpg',
            title: 'Des relaxations',
            text: 'Aux bols tibétains',
            isImageBeforeTitle: true, logo: 'petit_logo_loren.png',),
          Activities(
            value: 'img_header_1.jpeg',
            title: 'De la guidance par oracles',
            text: '',
            isImageBeforeTitle: false, logo: 'petit_logo_loren.png',),
          Activities(
            value: 'pied.png',
            title: 'De l\'hypnose',
            text: '',
            isImageBeforeTitle: true, logo: 'petit_logo_loren.png',),


        ],
      ),
    );
  }
}
