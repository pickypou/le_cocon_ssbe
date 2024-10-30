import 'package:flutter/material.dart';

import '../common/widget/activities.dart';

class ActivitiesSport extends StatelessWidget {
  const ActivitiesSport({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context); // Obtention de la taille de l'écran
    return  SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Activities(
            title: 'Gym Douce : mercredi 14h',
            text: "Vous souffrez d'affection de longue Durée (ALD) et cela fait longtemps que vous avez arrêté toutes activités physiques. Vous voulez reprendre en douceur ? Retrouvez votre mobilité, votre souplesse et votre force avec des activités sur chaise, avec matériel (poids léger, élastique, vélo, swiss-ball, power plate) ou avec poids de corps.",
            richText:'',
            value: 'gim_douce.png',
            isImageBeforeTitle: false,
            logo: 'cardio.png',
          ),
          Activities(
            value: 'yoga.png',
            title: 'Yoga',
            text: '',
            richText: '',
            isImageBeforeTitle: true,
            logo: 'cardio.png',
          ),
          Activities(
            value: 'stretching.png',
            title: 'Stretching',
            text: '',
            richText: '',// Peut ajouter un texte descriptif ici
            isImageBeforeTitle: false,
            logo: 'cardio.png',
          ),
          Activities(
            value: 'yoga.png',
            title: 'Yoga parents/enfants',
            text: '',
            richText: '',// Peut ajouter un texte descriptif ici
            isImageBeforeTitle: true,
            logo: 'cardio.png',
          ),
          Activities(
            value: 'taiso.png',
            title: 'Taiso',
            text: '',
            richText: '',// Peut ajouter un texte descriptif ici
            isImageBeforeTitle: false,
            logo: 'cardio.png',
          ),
          Activities(
            value: 'yoga.png',
            title: 'Coaching individuel',
            text: 'Uniquement sur rendez-vous',
            richText: '',
            isImageBeforeTitle: true,
            logo: 'cardio.png',
          ),
        ],
      ),
    );
  }
}
