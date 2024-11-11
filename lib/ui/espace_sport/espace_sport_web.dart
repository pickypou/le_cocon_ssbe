import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/common/widget/bulle_dialogue.dart';
import 'package:le_cocon_ssbe/ui/common/widget/custom_button.dart';
import 'package:le_cocon_ssbe/ui/espace_sport/activities_sport.dart';
import 'package:le_cocon_ssbe/ui/espace_sport/tarifs_horaires.dart';
import 'package:url_launcher/url_launcher.dart';
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
              const CustomText(phrase: 'Espace, Remise en, Forme')
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/gerard.png',
                fit: BoxFit.contain,
                width: size.width / 4,
              ),
              BulleDialogue(
                text:
                    "Peu importe votre objectif, je vous propose des activités de la plus douce à la plus intense.",
                color: theme.colorScheme.secondary,
                width: size.width * 0.34,
                height: size.height * 0.27,
                textXOffset: 0,
                textYOffset: -38,
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Text('Qui suis-je?',
              style: titleStyleSmall(
                  context) //.copyWith(fontSize: size.width / 47),
              ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
            child: Center(
              child: RichText(
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
                          'degré, BPJEPS, professeur de yoga D.U, coach sportif à domicile & diplômé éducateur Sport Santé, je m\'occupe de vous préparer un programme (en présentiel ou à distance) pour entretenir votre forme physique et votre mobilité, tout cela par le biais d\'activité ',
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
                      text: 'écurisée, ',
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
            height: 5,
          ),
          const ActivitiesSport(),
          const SizedBox(height: 5,),
          TarifsHoraires(fraction: 2, size:size),
          Text("Pour plus de renseignent visité mon site internet", style: textStyleText(context),),
          CustomButton(
            onPressed: () async {
              final Uri url = Uri.parse('https://www.gerardducro.com/'); // Remplacez par l'URL de votre choix
              if (await canLaunchUrl(url)) {
                await launchUrl(url);
              } else {
                throw 'Could not launch $url';
              }
            },
              label:
            'Pour plus d\'infos',

          )
        ]));
  }
}
