import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/widget/activities.dart';
import '../common/widget/custom_button.dart';


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
            isImageBeforeTitle: false, logo: 'petit_logo_loren.png',
          ),
          const Activities(
            value: 'palmaire.jpg',
            title: 'Divers massages',
            text: '',
            isImageBeforeTitle: true, logo: 'petit_logo_loren.png',
          ),
          const Activities(
            value: 'img_header_1.jpeg',
            title: 'Du magnétisme',
            text: '',
            isImageBeforeTitle: false, logo: 'petit_logo_loren.png'),
          const Activities(
            value: 'bol_tibetains.jpg',
            title: 'Des relaxations',
            text: 'Aux bols tibétains',
            isImageBeforeTitle: true, logo: 'petit_logo_loren.png',),
          const Activities(
            value: 'img_header_1.jpeg',
            title: 'De la guidance par oracles',
            text: '',
            isImageBeforeTitle: false, logo: 'petit_logo_loren.png',),
          const Activities(
            value: 'pied.png',
            title: 'De l\'hypnose',
            text: '',
            isImageBeforeTitle: true, logo: 'petit_logo_loren.png',),
           const SizedBox(height: 25,),
      CustomButton(
        onPressed: () async {
          final Uri url = Uri.parse('https://www.aucoeurdelesensciel.com/');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        label:
          'Pour plus d\'infos',


      )


        ],
      ),
    );
  }
}
