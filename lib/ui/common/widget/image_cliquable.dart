import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClickableImage extends StatelessWidget {
  const ClickableImage({super.key});

  @override
  Widget build(BuildContext context) {
    final String imagePath = 'assets/images/logo_cocon.png';
    final String url = 'https://app-lecoconssbe.web.app/';

    return Center(
      child: GestureDetector(
        onTap: () async {
          if (await canLaunchUrl(url as Uri)) {
            await launchUrl(url as Uri);
          } else {
            throw 'Impossible d\'ouvrir l\'URL $url';
          }
        },
        child: Image.asset(imagePath, width: 75, height: 75), // Ajustez la taille selon vos besoins
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Image Cliquable'),
      ),
      body: ClickableImage(),
    ),
  ));
}
