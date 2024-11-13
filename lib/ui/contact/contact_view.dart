import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/common/widget/text_custom.dart';
import 'package:le_cocon_ssbe/ui/contact/contact_bient_etre.dart';
import 'package:le_cocon_ssbe/ui/contact/contact_sport_sante.dart';

import '../form_contact/form_contact.dart';
import 'contact_le_cocon.dart';

class ContactView extends StatelessWidget {
  const ContactView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                phrase: 'Nous, Contacter',
              ),
              const SizedBox(height: 20),
              Flexible(
                fit: FlexFit.loose,
                child: LayoutBuilder(
                  builder: (context, innerConstraints) {
                    if (innerConstraints.maxWidth > 600) {
                      // Version desktop
                      return const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ContactBientEtre(),
                                SizedBox(height: 10),
                                ContactSportSante(),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FormContact(),
                                SizedBox(height: 10),
                                ContactLeCocon(),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      // Version mobile
                      return const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ContactBientEtre(),
                          SizedBox(height: 10),
                          ContactSportSante(),
                          SizedBox(height: 20),
                          FormContact(),
                          SizedBox(height: 10),
                          ContactLeCocon(),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
