import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkText extends StatelessWidget {
  final String text;
  final String url;

  const LinkText({super.key, required this.text, required this.url});

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
        enableDomStorage: true,
      ),
    )) {
      throw 'Impossible d\'ouvrir l\'URL $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: _launchURL,
      child: Text(
        text,
        style: textStyleText(context).copyWith(fontSize: size.width / 27),
      ),
    );
  }
}
