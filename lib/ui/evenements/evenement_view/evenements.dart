import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

class Evenements extends StatelessWidget {
  const Evenements({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Evénements',
                  style: titleStyleMedium(context)
                      .copyWith(fontSize: size.width / 10)),
              Image.asset(
                'assets/images/evenement.png',
                fit: BoxFit.contain,
              ),
            ],
          )),
    );
  }
}
