import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/common/widget/link_text.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

import '../common/widget/text_custom.dart';

class EspaceSportMobile extends StatelessWidget {
  const EspaceSportMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo_gerard.png',
            fit: BoxFit.contain,
            width: size.width / 2,
          ),
          const Center(
            child: CustomText(phrase: 'Espace, Sport, Santé'),
          ),
          const SizedBox(height: 25),
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
              ),
            ),
            child: Image.asset(
              'assets/images/gerard_velo.png',
              fit: BoxFit.contain,
              width: size.width / 1.5,
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: textStyleText(context).copyWith(
                    fontSize: size.width / 30,
                    fontWeight: FontWeight.w600,
                    height: 1.5),
                children: [
                  const TextSpan(
                    text:
                        'Gérard, Professeur de judo, 6éme dan, BE 1er degré, BPJEPS, professeur de yoga D.U, coach sportif à domicile et diplômé éducateur Sport Santé, je m\'occupe de vous préparer un programe (en presentiel ou à distance) pour entretenir votre forme physique et votre mobilité. tout cela par le biais d\'activité, ',
                  ),
                  TextSpan(
                    text: 'R',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                  const TextSpan(text: 'égulière, '),
                  TextSpan(
                    text: 'A',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                  const TextSpan(text: 'daptée, '),
                  TextSpan(
                    text: 'S',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                  const TextSpan(text: 'ecurisé, '),
                  TextSpan(
                    text: 'P',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                  ),
                  const TextSpan(text: 'rogressive. (Appelletion OMS).'),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          const LinkText(
              text: 'Pour plus de renseignement www.gerard.fr',
              url: 'https://www.gerad.fr')
        ],
      ),
    );
  }
}
