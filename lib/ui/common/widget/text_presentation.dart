import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

import 'text_custom.dart';

class TextPresentation extends StatelessWidget {
  final double? fontSize;
  const TextPresentation({super.key, this.fontSize});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double calculatedFontSize =
        fontSize ?? (size.width > 749 ? size.width / 75 : 18);
    return SizedBox(
      width: size.width, // Utilisez la largeur de l'écran si nécessaire
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/papillon.png',
                fit: BoxFit.contain,
                width: size.width / 3.4, // Ajustez la largeur selon vos besoins
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    phrase: 'Pourquoi le, Cocon ?',
                    // Supprimer le \n pour réduire l'espace
                  ),
                  SizedBox(
                      height: 5), // Ajustez cet espacement si nécessaire
                  CustomText(
                    phrase: 'Sport, Santé, Bien, Etre',
                  ),
                ],
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center, // Aligner le texte au centre
                    child: Text(
                      'Dans une société qui va de plus en plus vite, où l’on nous demande encore de plus de choses urgentes que ce soit dans le cadre professionnel ou familial, l’homme moderne du XXIe siècle oublie souvent de prendre soin de lui et de sa santé. Il en découle des douleurs physiques ou même émotionnelles.  Parce qu’être en bonne santé ne signifie pas seulement absence de maladie. C’est pour cela que Loren et Gerard ont décidé de créer en 2022 ce centre de sport Santé Bien-être appelé le Cocon S-S-B-E, lieu de proximité, convivial  & rempli de bienveillance. Cet espace alliant le physique et lepsychique est l’endroit idéal pour vous aider dans votre transformation, et vous permettre de vous sentir bien dans votre corps comme dans votre esprit.',
                      style: textStyleText(context).copyWith(
                          height: 1.5, // Ajustez la hauteur de ligne ici
                          fontSize: calculatedFontSize),
                      textAlign:
                          TextAlign.center, // Centrer le texte horizontalement
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment:
                            Alignment.center, // Aligner le texte au centre
                        child: Text(
                          'Il se situe au 59 rue Nationale',
                          style: textStyleText(context).copyWith(
                              height: 1.5, // Ajustez la hauteur de ligne ici
                              fontSize: calculatedFontSize),
                          textAlign: TextAlign
                              .center, // Centrer le texte horizontalement
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.center, // Aligner le texte au centre
                    child: Text(
                      '59185 PROVIN',
                      style: textStyleText(context).copyWith(
                          height: 1.5, // Ajustez la hauteur de ligne ici
                          fontSize: calculatedFontSize),
                      textAlign:
                          TextAlign.center, // Centrer le texte horizontalement
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.center, // Aligner le texte au centre
                    child: Text(
                      'A l\'interieur de ce bâtiment, il y a deux partie distintes, mais tout compte fait pas si distintes que ça, où nos deux professionnels vous acceuillent du lundi au samedi',
                      style: textStyleText(context).copyWith(
                          height: 1.5, // Ajustez la hauteur de ligne ici
                          fontSize: calculatedFontSize),
                      textAlign:
                          TextAlign.center, // Centrer le texte horizontalement
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
