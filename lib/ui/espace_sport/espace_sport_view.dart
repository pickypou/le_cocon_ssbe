import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/espace_sport/espace_sport_mobile.dart';

import 'espace_sport_web.dart';

class EspaceSportView extends StatelessWidget {
  const EspaceSportView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    if (size.width < 750) {
      return const SizedBox(
        child: Padding(
            padding: EdgeInsets.all(25), child: EspaceSportMobile()),
      );
    } else {
      return const SizedBox(
        child: EspaceSportWeb(),
      );
    }
  }
}
