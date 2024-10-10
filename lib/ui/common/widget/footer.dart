import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<void> _openPdf(BuildContext context) async {
    try {
      // Afficher un indicateur de chargement
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      print("Tentative de récupération du PDF...");

      // Récupérer l'URL du PDF depuis Firebase Storage
      final ref = FirebaseStorage.instance.ref().child('mention_legal.pdf');
      final url = await ref.getDownloadURL();

      // Fermer l'indicateur de chargement
      Navigator.of(context).pop();

      // Lancer le PDF
      print("Tentative d'ouverture du PDF...");
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        print("PDF lancé avec succès");
      } else {
        throw 'Impossible d\'ouvrir le PDF à l\'adresse $url';
      }
    } catch (e, stackTrace) {
      print("Erreur inattendue : $e");
      print("Stack trace : $stackTrace");
      Navigator.of(context).pop(); // Fermer l'indicateur de chargement
      _showErrorDialog(context, 'Erreur inattendue: $e\n\nStack trace: $stackTrace');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
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
                onTap: () => _openPdf(context),
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