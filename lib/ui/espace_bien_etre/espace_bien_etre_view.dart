import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/espace_bien_etre/espace_bien_etre_mobile.dart';
import 'package:le_cocon_ssbe/ui/espace_bien_etre/espace_bien_etre_web.dart';

class EspaceBienEtreView extends StatelessWidget {

  const EspaceBienEtreView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    if (size.width < 750) {
      return const SizedBox(
        child: Padding(
            padding: EdgeInsets.all(25), child: EspaceBienEtreMobile()),
      );
    } else {
      return const SizedBox(
        child: EspaceBienEtreWeb(),
      );
    }
  }
}
