import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/espace_sport/horaires_tarifs.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

import '../common/widget/activities.dart';

class ActivitiesSportMobile extends StatelessWidget {
  const ActivitiesSportMobile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
        appBar: AppBar(
            title: Text(
          'Mes activitées',
          style: textStyleText(context).copyWith(fontSize: size.width / 20),
        )),
        body: SingleChildScrollView(
            child: SizedBox(
                child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Activities(
                title: 'Gym Douce : mercredi 14h',
                text:
                    "Vous souffrez d'affection de longue Durée (ALD) et cela fait longtemps que vous avez arrêté toutes activités physiques. Vous voulez reprendre en douceur ? Retrouvez votre mobilité, votre souplesse et votre force avec des activités sur chaise, avec matériel (poids léger, élastique, vélo, swiss-ball, power plate) ou avec poids de corps.",
                value: 'gim_douce.png',
                isImageBeforeTitle: false,
                logo: 'cardio.png',
              ),
              const SizedBox(
                height: 20,
              ),
              Activities(
                title: 'Yoga : lundi 14h00 / vendredi 19h00',
                text:
                    "Que ce soit hatha yoga, vinyasa yoga, yoga nidra, ou un yoga traditionnel thérapeutique en direct d'inde (Kaivalyadhama), un travail de mobilité associé à la respiration et de la spiritualité va vous aider sur le chemin de la connaissance de soi. Dans une société qui vous en demande toujours plus, dans la séance de yoga, je vous propose de faire une pause.",
                value: 'yoga.png',
                isImageBeforeTitle: true,
                logo: 'cardio.png',
              ),
              const SizedBox(
                height: 20,
              ),
              Activities(
                value: 'stretching.png',
                title: 'Stretching : mercredi 19h00',
                text:
                    'Avec un travail sur le muscle profond, par étirement et contractions isométriques retrouvez votre souplesse.',
                isImageBeforeTitle: false,
                logo: 'cardio.png',
              ),
              const SizedBox(
                height: 20,
              ),
              Activities(
                value: 'yoga_parent_enfant.jpeg',
                title: 'Yoga parents/enfants : mercredi 09h30',
                text:
                    'Venez partager un moment de complicité avec votre enfant (+ 4ans) avec des postures ludiques et agréables et créer un lien filial.',
                isImageBeforeTitle: true,
                logo: 'cardio.png',
              ),
              const SizedBox(
                height: 20,
              ),
              Activities(
                value: 'taiso.jpeg',
                title:
                    'Taiso : Mardi 19h00 & samedi 10h00 \n (Préparation du corps en japonais)',
                text:
                    "Méthode japonaise de renforcement musculaire de l'ensemble de votre corps de la tête jusqu'au petit orteil. 15' d'échauffement, 30' de renforcement musculaire sur les grands groupes , les jambes, abdos, fessiers, dos etc...  suivi par un temps calme : association d'étirement et de relaxation",
                isImageBeforeTitle: false,
                logo: 'cardio.png',
              ),
              const SizedBox(
                height: 20,
              ),
              Activities(
                value: 'yoga.png',
                title: 'Coaching individuel : Uniquement sur rendez-vous ',
                text:
                    "Vous préférez décider de votre activité et / ou de vos horaires, je peux intervenir chez vous ou vous recevoir au Cocon ou encore en visio.\n Besoin de vous remuscler?\n A la recherche d'une mobilité après une opération ?\n Envie de perdre du poids?\n Vous souffrez de troubles musculo-squelettiques, Obésité, diabète (type 2), troubles respiratoires ou de stress excessif chronique etc... Exposez-moi votre problématique et j'adapte votre programme sur mesure",
                isImageBeforeTitle: true,
                logo: 'cardio.png',
              ),
              const SizedBox(
                height: 25,
              ),
              HorairesTarifs(),
            ],
          ),
        ))));
  }
}
