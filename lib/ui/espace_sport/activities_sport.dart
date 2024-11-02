import 'package:flutter/material.dart';

import '../common/widget/activities.dart';

class ActivitiesSport extends StatelessWidget {
  const ActivitiesSport({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child:Padding(
          padding: EdgeInsets.all(75),
     child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Activities(
            title: 'Gym Douce : mercredi 14h',
            text: "Vous souffrez d'affection de longue Durée (ALD) et cela fait longtemps que vous avez arrêté toutes activités physiques. Vous voulez reprendre en douceur ? Retrouvez votre mobilité, votre souplesse et votre force avec des activités sur chaise, avec matériel (poids léger, élastique, vélo, swiss-ball, power plate) ou avec poids de corps.",
            value: 'gim_douce.png',
            isImageBeforeTitle: false,
            logo: 'cardio.png',
          ),
          Activities(
            title: 'Yoga : lundi 14h00 / vendredi 19h00',
            text: "Que ce soit hatha yoga, vinyasa yoga, yoga nidra, ou un yoga traditionnel thérapeutique en direct d'inde (Kaivalyadhama), un travail de mobilité associé à la respiration et de la spiritualité va vous aider sur le chemin de la connaissance de soi. Dans une société qui vous en demande toujours plus, dans la séance de yoga, je vous propose de faire une pose.",
            value: 'yoga.png',
            isImageBeforeTitle: true,
            logo: 'cardio.png',
          ),
          Activities(
            value: 'stretching.png',
            title: 'Stretching : mercredi 19h00',
            text: 'Avec un travail sur le muscle profond, par étirement et contractions isométriques retrouvez votre souplesse.',

            isImageBeforeTitle: false,
            logo: 'cardio.png',
          ),
          Activities(
            value: 'yoga.png',
            title: 'Yoga parents/enfants : mercredi 09h30',
            text: 'Venez partager un moment de complicité avec votre enfant(+ 4ans) avec des posture ludique et agréable et créer un lien filial.',
            isImageBeforeTitle: true,
            logo: 'cardio.png',
          ),
          Activities(
            value: 'taiso.png',
            title: 'Taiso : Mardi 19h00 & samedi 10h00 \n (Préparation du corps en japonais)',
            text: "Méthode japonaise de renforcement musculaire de l'ensemble de votre corp de la tête jusqu'au petit orteil. 15' d'échauffement, 30' de renforcement musculaire sur les grand groupes , les jambes, abdo, fessier, dos etc... qui est suivi par un temps calme association d'étirement et de relaxation",
            isImageBeforeTitle: false,
            logo: 'cardio.png',
          ),
          Activities(
            value: 'yoga.png',
            title: 'Coaching individuel : Uniquement sur rendez-vous ',
            text: "Vous préférez decider de votre activité et / ou de vos horaires, je peux intervenir chez vous ou vous recevoir au Cocon ou encore en visio.\n Besoin de vous remuscler?\n a la d'une mobilité après une opération. Envie de perdre du poids?\n Vous souffrez de trouble musculaire-squelettiques, Obésité, diabète(type 2), trouble respiratoire ou de stress exesif chronique etc... Exposez moi votre problématique et j'adapte votre programme sur mesure",
            isImageBeforeTitle: true,
            logo: 'cardio.png',
          ),
        ],
      ),
      )
    );
  }
}
