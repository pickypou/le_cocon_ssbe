import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

class Presentation extends StatelessWidget {
  const Presentation({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Center(
      child: Column(
        // Utilisation de Column pour empiler les éléments
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceEvenly, // Espacement uniforme
            crossAxisAlignment: CrossAxisAlignment.start, // Alignement en haut
            children: [
              // Premier groupe d'images
              Column(
                children: [
                  Image.asset(
                    'assets/images/sport.png',
                    width: size.width / 4,
                  ),
                  const SizedBox(height: 10), // Espace entre l'image et la suivante
                  Transform.rotate(
                    angle: 0.1,
                    child: Image.asset(
                      'assets/images/polaroid_gerard.jpeg',
                      fit: BoxFit.contain,
                      width: size.width / 3.8,
                    ),
                  ),
                ],
              ),
              Image.asset(
                'assets/images/papillon.png',
                width: size.width / 4,
              ),
              // Deuxième groupe d'images
              Column(
                children: [
                  Image.asset('assets/images/logo_loren_nb.png'),
                  Transform.rotate(
                    angle: -0.1,
                    child: Image.asset(
                      'assets/images/polaroid_loren.jpeg',
                      fit: BoxFit.contain,
                      width: size.width / 4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 35),
          Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        'L\'alliance entre ces deux univers qui unit Corps & Esprit au sein ', // Texte en dessous des groupes
                        style: textStyleText(context).copyWith(
                            fontSize: size.width / 75) // Texte en gras
                        ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                        'du Cocon : lieu de transformation', // Texte en dessous des groupes
                        style: textStyleText(context).copyWith(
                            fontSize: size.width / 75) // Texte en gras
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}


