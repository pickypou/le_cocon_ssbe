import 'package:flutter/material.dart';

import '../common/widget/activities.dart';
import '../theme.dart';

class ActivityBienEtreMobile extends StatelessWidget {
  const ActivityBienEtreMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Mes activitées',
          style: textStyleText(context).copyWith(fontSize: size.width / 20),
        )),
        body: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Activities(
                title: 'Des soins énergétiques',
                text: '',
                value: 'tete.png',
                isImageBeforeTitle: false,
                logo: 'petit_logo_loren.png',
              ),
              const Activities(
                value: 'massage.png',
                title: 'Divers massages',
                text: '',
                isImageBeforeTitle: true,
                logo: 'petit_logo_loren.png',
              ),
              const Activities(
                  value: 'img_header_1.jpeg',
                  title: 'Du magnétisme',
                  text: '',
                  isImageBeforeTitle: false,
                  logo: 'petit_logo_loren.png'),
              const Activities(
                value: 'bol_tibetains.jpg',
                title: 'Des relaxations',
                text: 'Aux bols tibétains',
                isImageBeforeTitle: true,
                logo: 'petit_logo_loren.png',
              ),
              const Activities(
                value: 'img_header_1.jpeg',
                title: 'De la guidance par oracles',
                text: '',
                isImageBeforeTitle: false,
                logo: 'petit_logo_loren.png',
              ),
              const Activities(
                value: 'pied.png',
                title: 'De l\'hypnose',
                text: '',
                isImageBeforeTitle: true,
                logo: 'petit_logo_loren.png',
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ));
  }
}
