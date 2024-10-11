import 'package:flutter/material.dart';

import '../common/widget/activities.dart';

class ActivitySport extends StatelessWidget {
  const ActivitySport({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Activities(
            title: 'Gym Douce',
            text: '',
            value: 'gim_douce.png',
            isImageBeforeTitle: false,
            logo: 'cardio.png',
          ),
          Activities(
            value: 'yoga.png',
            title: 'Yoga',
            text: '',
            isImageBeforeTitle: true,
            logo: 'cardio.png',
          ),
          Activities(
              value: 'stretching.png',
              title: 'Stretching',
              text: '',
              isImageBeforeTitle: false,
            logo: 'cardio.png',),
          Activities(
              value: 'yoga.png',
              title: 'Yoga parents/enfants',
              text: '',
              isImageBeforeTitle: true,
            logo: 'cardio.png',),
          Activities(
              value: 'taiso.png',
              title: 'Taiso',
              text: '',
              isImageBeforeTitle: false,
            logo: 'cardio.png',),
          Activities(
              value: 'yoga.png',
              title: 'Coaching individuel',
              text: 'Uniquement sur rendez-vous',
              isImageBeforeTitle: true,
            logo: 'cardio.png',),


        ],
      ),
    );
  }
}
