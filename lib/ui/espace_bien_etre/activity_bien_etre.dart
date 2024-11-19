import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/common/widget/link_button.dart';
import '../common/widget/activities.dart';

class ActivityBienEtre extends StatelessWidget {
  const ActivityBienEtre({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              value: 'magnetisme.jpg',
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
            value: 'guidance.jpg',
            title: 'De la guidance par oracles',
            text: '',
            isImageBeforeTitle: false,
            logo: 'petit_logo_loren.png',
          ),
          const Activities(
            value: 'hypnose.jpg',
            title: 'De l\'hypnose',
            text: '',
            isImageBeforeTitle: true,
            logo: 'petit_logo_loren.png',
          ),
          const SizedBox(
            height: 25,
          ),
          LinkButton(label: 'Consultez mon site internet',
              url: 'https://www.aucoeurdelesensciel.com')
        ],
      ),
    );
  }
}
