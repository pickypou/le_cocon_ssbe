import 'package:flutter/material.dart';

import '../common/widget/link_text.dart';
import '../common/widget/text_custom.dart';
import '../theme.dart';

class EspaceBienEtreMobile extends StatelessWidget {
  const EspaceBienEtreMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
              'assets/images/loren_2.jpg',
              fit: BoxFit.contain,
              width: size.width / 1.5,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'En tant que masso-thérapeute, énergéticienne\n'
            ' je vous propose divers soins tel que',
            style: textStyleText(context).copyWith(fontSize: size.width / 27),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Des soins énergétique',
              style: textStyleText(context).copyWith(fontSize: size.width / 27),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              'Divers massages',
              style: textStyleText(context).copyWith(fontSize: size.width / 27),
            ),
          ]),
          const SizedBox(
            height: 15,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Du magnétisme',
              style: textStyleText(context).copyWith(fontSize: size.width / 27),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              'De l\'hypnose',
              style: textStyleText(context).copyWith(fontSize: size.width / 27),
            ),
          ]),
          const SizedBox(
            height: 15,
          ),
          const LinkText(
              text: 'Pour plus de renseignement www.aucoeurdelesensciel.com',
              url: 'https://www.aucoeurdelesensciel.com')
        ],
      ),
    );
  }
}
