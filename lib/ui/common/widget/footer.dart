import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/common/widget/pdf_viewver.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme.dart';
import 'image_cliquable.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Divider(
          color: theme.colorScheme.secondary,
          thickness: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClickableImage(),
              Text('© 2024 Le CoconSSBE - Tous droits réservés',
                  style: textStyleText(context)
                      .copyWith(fontSize: size.width / 75)),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PDFViewerPage(),
                      ),
                    );
                  },
                  child: Text('Mentions_légales',
                      style: textStyleText(context)
                          .copyWith(fontSize: size.width / 75))),
              TextButton(
                onPressed: () async {
                  final Uri url = Uri.parse('https://ludovicspysschaert.fr/');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    // Tu peux afficher une erreur ici
                    throw 'Impossible d’ouvrir l’URL : $url';
                  }
                },
                child:
                Text('Céation Ludovic SPYSSCHAERT', style:textStyleText(context).copyWith(fontSize: 10, color: theme.colorScheme.error), textAlign: TextAlign.end,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
