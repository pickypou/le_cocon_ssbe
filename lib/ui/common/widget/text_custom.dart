import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

class CustomText extends StatelessWidget {
  final String phrase;

  const CustomText({super.key, required this.phrase, });

  @override
  Widget build(BuildContext context) {
    // Obtenez la largeur de l'écran pour calculer la taille de la police
    double screenWidth = MediaQuery.of(context).size.width;

    // Calculer une taille de police responsive en fonction de la largeur de l'écran
    double fontSize =
        screenWidth * 0.05; // Ajustez ce facteur selon vos besoins

    return RichText(
      text: TextSpan(
        children: phrase.split(', ').map((word) {
          return TextSpan(
            children: [
              TextSpan(
                text: word.substring(0, 1), // Première lettre avec 'Autography'
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontFamily: 'Autography',
                  fontSize: fontSize, //Taille de la police responsive
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0, // Ajustez ici pour plus d'espace
                ),
              ),
              TextSpan(
                text: word.substring(1), // Reste du mot avec 'Amable'
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontFamily: 'Amable',
                  fontSize: fontSize, // Taille de la police responsive
                  letterSpacing: 2.0, // Ajustez ici aussi pour plus d'espace
                ),
              ),
              const TextSpan(text: ' '), // Espace entre les mots
            ],
          );
        }).toList(),
      ),
    );
  }
}
