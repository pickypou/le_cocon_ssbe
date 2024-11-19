import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/common/widget/bulle_dialogue.dart';
import '../common/widget/text_custom.dart';
import '../theme.dart';

class EspaceBienEtreWeb extends StatelessWidget {
  const EspaceBienEtreWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/logo_loren.png',
                fit: BoxFit.contain,
                width: size.width / 6,
              ),

              const CustomText(phrase: 'Espace, Bien, Etre')
            ],
          ),
          const SizedBox(height: 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/loren_1.png',
                fit: BoxFit.contain,
                width: size.width / 5,
              ),
              const SizedBox(width: 35,),

              BulleDialogue(
                text: '"Je suis là pour vous aider à retrouver un équilibre Corps / Ame / Esprit que vous souffriez de douleurs physiques ou émotionnelles ."',
                color: theme.colorScheme.secondary,
                width: size.width * 0.4,
                height: size.height *0.3,
                textXOffset: 0,
                textYOffset: -48,
              ),
            ],
          ),
        const SizedBox(height: 25,),
        Text('Qui suis-je?', style: titleStyleSmall(context),),
    SizedBox(
    child: Padding(
        padding: const EdgeInsets.all(65),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Je suis Loren, praticienne masso-thérapeute & énergéticienne installée depuis 2019.',
              style: textStyleText(context)),
          Text('Après de nombreuses formations en soins holistiques, je me suis constituée ma propre boîte à outils avec divers techniques qui me permet d\'accompagner chaque personne dans sa globalité pour réaligner corps/âme et esprit.',
            style: textStyleText(context),),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('Dans cette boîte il y a :',style: textStyleText(context),
          )

          ),
        ],
      ),
    )
          ),



        ],
      ),

    );
  }
}
