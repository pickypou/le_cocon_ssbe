import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme.dart';

class LinkButton extends StatelessWidget {
  final String label;
  final String url;
  final double? fontSize;

  const LinkButton(
      {super.key, required this.label, required this.url, this.fontSize});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Impossible d\'ouvrir le lien : $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth > 749 ? 450.0 : 300.0;
    double calculatedFontSize =
        fontSize ?? (size.width > 749 ? size.width / 75 : 18);
    return SizedBox(
        width: buttonWidth,
        child: ElevatedButton(
          onPressed: () => _launchURL(url),
          style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(vertical: 2)),
              backgroundColor:
                  WidgetStateProperty.all(theme.colorScheme.surface),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: theme.colorScheme.onSurface)))),
          child: Text(
            label,
            style: textStyleText(context).copyWith(
                fontSize:
                    calculatedFontSize), // Souligner le texte pour montrer que c'est un lien
          ),
        ));
  }
}
