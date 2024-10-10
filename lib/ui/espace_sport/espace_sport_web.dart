import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/common/widget/bulle_dialogue.dart';
import 'package:le_cocon_ssbe/ui/espace_sport/activity_sport.dart';

import '../common/widget/text_custom.dart';
import '../theme.dart';

class EspaceSportWeb extends StatelessWidget {
  const EspaceSportWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
        width: size.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/logo_gerard.png',
                fit: BoxFit.contain,
                width: size.width / 4.5,
              ),
              CustomText(phrase: 'Espace, Remise en, Forme')
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/gerard.png',
                fit: BoxFit.contain,
                width: size.width / 5.1,
              ),
              BulleDialogue(
                text:
                    "Peu importe votre objectif, je vous propose des activités de la plus douce à la plus intense.",
                color: theme.colorScheme.secondary,
                width: size.width *0.28,
                height: size.height * 0.28,
                textXOffset: 0,
                textYOffset: -38,
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Qui suis je?',
            style: titleStyleSmall(context)//.copyWith(fontSize: size.width / 47),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
            child: Center(
              child:

            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Gérard, Professeur de judo, ',
                    style: textStyleText(context)
                        .copyWith(fontSize: size.width / 75),
                  ),
                  TextSpan(
                    text: '6',
                    style: textStyleText(context)
                        .copyWith(fontSize: size.width / 75),
                  ),
                  TextSpan(
                    text: 'ème DAN, ',
                    style: textStyleText(context).copyWith(
                        fontSize: size.width / 75), // Plus petit pour "ème"
                  ),
                  TextSpan(
                    text: 'BE ',
                    style: textStyleText(context)
                        .copyWith(fontSize: size.width / 75),
                  ),
                  TextSpan(
                    text: '1',
                    style: textStyleText(context)
                        .copyWith(fontSize: size.width / 75),
                  ),
                  TextSpan(
                    text: 'er, ',
                    style: textStyleText(context).copyWith(
                        fontSize: size.width / 75), // Plus petit pour "er"
                  ),
                  TextSpan(
                    text:
                        'degré, BPJEPS, professeur de yoga D.U, coach sportif à domicile & diplômé éducateur Sport Santé, je m\'occupe de vous préparer un programme (en présentiel ou à distance) pour entretenir votre forme physique et votre mobilité. Tout cela par le biais d\'activité ',
                    style: textStyleText(context)
                        .copyWith(fontSize: size.width / 75),
                  ),
                  TextSpan(
                    text: 'R',
                    style: textStyleText(context).copyWith(
                        fontSize: size.width / 75,
                        color: Colors.red), // Rouge pour "R"
                  ),
                  TextSpan(
                    text: 'égulière, ',
                    style: textStyleText(context)
                        .copyWith(fontSize: size.width / 75),
                  ),
                  TextSpan(
                    text: 'A',
                    style: textStyleText(context).copyWith(
                        fontSize: size.width / 75,
                        color: Colors.red), // Rouge pour "A"
                  ),
                  TextSpan(
                    text: 'daptée, ',
                    style: textStyleText(context)
                        .copyWith(fontSize: size.width / 75),
                  ),
                  TextSpan(
                    text: 'S',
                    style: textStyleText(context).copyWith(
                        fontSize: size.width / 75,
                        color: Colors.red), // Rouge pour "S"
                  ),
                  TextSpan(
                    text: 'écurisé, ',
                    style: textStyleText(context)
                        .copyWith(fontSize: size.width / 75),
                  ),
                  TextSpan(
                    text: 'P',
                    style: textStyleText(context).copyWith(
                        fontSize: size.width / 75,
                        color: Colors.red), // Rouge pour "P"
                  ),
                  TextSpan(
                    text: 'rogressive. ',
                    style: textStyleText(context)
                        .copyWith(fontSize: size.width / 75),
                  ),
                  TextSpan(
                    text: '(Appellation OMS)',
                    style: textStyleText(context)
                        .copyWith(fontSize: size.width / 75),
                  ),
                ],
              ),
            ),
          ),
          ),
          const SizedBox(
            height: 25,
          ),
          ActivitySport()
        ]));
  }
}
