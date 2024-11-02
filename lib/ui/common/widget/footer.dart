import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  FooterState createState() => FooterState();
}

class FooterState extends State<Footer> {
  Future<void> _openPdf() async {
    try {
      // Afficher un indicateur de chargement
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      debugPrint("Tentative de récupération du PDF...");

      // Récupérer l'URL du PDF depuis Firebase Storage
      final ref = FirebaseStorage.instance.ref().child('mention_legal.pdf');
      final url = await ref.getDownloadURL();

      // Vérifier si le widget est toujours monté avant de fermer le dialog
      if (!mounted) return;
      Navigator.of(context).pop();

      // Lancer le PDF
      debugPrint("Tentative d'ouverture du PDF...");
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        debugPrint("PDF lancé avec succès");
      } else {
        throw 'Impossible d\'ouvrir le PDF à l\'adresse $url';
      }
    } catch (e, stackTrace) {
      debugPrint("Erreur inattendue : $e");
      debugPrint("Stack trace : $stackTrace");

      if (mounted) Navigator.of(context).pop(); // Fermer l'indicateur de chargement
      _showErrorDialog('Erreur inattendue: $e\n\nStack trace: $stackTrace');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erreur'),
          content: SingleChildScrollView(
            child: Text(message),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
              Text(
                  '© 2024 Le CoconSSBE - Tous droits réservés',
                  style: textStyleText(context).copyWith(fontSize: size.width / 75)
              ),
              GestureDetector(
                onTap: _openPdf,
                child: Text(
                    'Mentions légales',
                    style: textStyleText(context).copyWith(
                      fontSize: size.width / 75,
                      decoration: TextDecoration.underline,
                    )
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
