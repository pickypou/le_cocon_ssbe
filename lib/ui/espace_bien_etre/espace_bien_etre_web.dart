import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/common/widget/bulle_dialogue.dart';
import 'package:le_cocon_ssbe/ui/espace_bien_etre/activity_bien_etre.dart';

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
                width: size.width / 6,
              ),

              BulleDialogue(
                text: '"Je suis là pour vous aider à retrouver un équilibre, relaxation & bien-être. Que vous souffriez de maux physiques ou émotionnels"',
                color: theme.colorScheme.secondary,
                width: size.width * 0.3,
                height: size.height *0.3,
                textXOffset: 0,
                textYOffset: -48,
              ),


            ],
          ),
        const SizedBox(height: 25,),
        Text('En tant que masso-thérapeute, énergéticienne je vous propose divers soins tel ques :',
        style: textStyleText(context).copyWith(fontSize: size.width/ 75),),
          const SizedBox(height: 25,),

          const ActivityBienEtre()
        ],
      ),
    );
  }
}
