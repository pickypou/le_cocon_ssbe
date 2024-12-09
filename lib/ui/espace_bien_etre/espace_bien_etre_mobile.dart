import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/espace_bien_etre/activity_bien_etre_mobile.dart';

import '../common/widget/custom_button.dart';
import '../common/widget/link_button.dart';
import '../common/widget/text_custom.dart';
import '../theme.dart';

class EspaceBienEtreMobile extends StatelessWidget {
  const EspaceBienEtreMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo_loren.png',
            fit: BoxFit.contain,
            width: size.width / 3,
          ),
          const CustomText(phrase: 'Espace, Bien, Etre')
        ],
      ),
      const SizedBox(
        height: 25,
      ),
      Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(4, 4),
              ),
            ],
            border: const Border(
              top: BorderSide(width: 20.0, color: Colors.white),
              left: BorderSide(width: 20.0, color: Colors.white),
              right: BorderSide(width: 20.0, color: Colors.white),
              bottom: BorderSide(width: 90.0, color: Colors.white),
            )),
        child: Image.asset(
          'assets/images/loren_2.jpeg',
          fit: BoxFit.contain,
          width: size.width / 1.5,
        ),
      ),
      const SizedBox(
        height: 25,
      ),
      Text('Qui suis-je?',
          style: titleStyleMedium(context).copyWith(
            fontSize: size.width / 12,
          )),
      SizedBox(
          child: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'Je suis Loren, praticienne masso-thérapeute & énergéticienne, installée depuis 2019',
                style:
                    textStyleText(context).copyWith(fontSize: size.width / 27)),
            Text(
                'Après de nombreuses formations en soins holistiques, je me suis constituée ma propre boîte à outils avec divers téchniques qui me permet d\'accompagner chaque personne dans sa globalité pour réaligner corps/âme et esprit.',
                style: textStyleText(context).copyWith(
                  fontSize: size.width / 27,
                )),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Dans cette boîte il y a :',
                  style: textStyleText(context)
                      .copyWith(fontSize: size.width / 27),
                )),
          ],
        ),
      )),
      Text(
        'Il y à divers  soins comme : ',
        style: textStyleText(context).copyWith(fontSize: size.width / 27),
      ),
      const SizedBox(
        width: 15,
      ),
      Text(
        'Des massages',
        style: textStyleText(context).copyWith(fontSize: size.width / 27),
      ),
      Text(
        'Du magnétisme ...',
        style: textStyleText(context).copyWith(fontSize: size.width / 27),
      ),
      const SizedBox(
        height: 15,
      ),
      CustomButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ActivityBienEtreMobile()),
          );
        },
        label: 'Voir tout ce que je propose',
      ),
      const SizedBox(
        height: 25,
      ),
      LinkButton(
        label: 'Consulter mon site internet',
        url: 'https://www.aucoeurdelesensciel.com',
      ),
    ]));
  }
}
