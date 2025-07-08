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
                Text('Création Ludovic SPYSSCHAERT', style:textStyleText(context).copyWith(fontSize: 10, color: theme.colorScheme.error), textAlign: TextAlign.end,),
              ),
              PopupMenuButton<String>(
                icon: Icon(Icons.info_outline, color: Colors.black), // Icône noire visible
                color: Colors.white, // Fond du menu
                onSelected: (value) {
                  if (value == 'mentions') {
                    launchUrl(Uri.parse('/mentions-legales.html'));
                  } else if (value == 'confidentialite') {
                    launchUrl(Uri.parse('/confidentialite.html'));
                  } else if (value == 'cookies') {
                    launchUrl(Uri.parse('/cookies.html'));
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'mentions',
                    child: Text(
                      'Mentions légales',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'confidentialite',
                    child: Text(
                      'Politique de confidentialité',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'cookies',
                    child: Text(
                      'Politique des cookies',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              )




            ],
          ),
        ),
      ],
    );
  }
}
