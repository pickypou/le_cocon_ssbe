import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/espace_sport/espace_sport_mobile.dart';

import 'espace_sport_web.dart';

class EspaceSportView extends StatelessWidget {
  const EspaceSportView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    if (size.width < 750) {
      return SizedBox(
        child: Padding(
            padding: const EdgeInsets.all(25), child: EspaceSportMobile()),
      );
    } else {
      return SizedBox(
        child: EspaceSportWeb(),
      );
    }
  }
}
