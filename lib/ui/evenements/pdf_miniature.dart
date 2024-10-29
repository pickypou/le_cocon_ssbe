import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thumbnailer/thumbnailer.dart';

class PDFMiniature extends StatelessWidget {
  final String pdfUrl;
  final double taille;

  const PDFMiniature({Key? key, required this.pdfUrl, this.taille = 100})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Thumbnail(
      dataResolver: () async {
        final response = await http.get(Uri.parse(pdfUrl));
        if (response.statusCode == 200) {
          return response.bodyBytes;
        } else {
          throw Exception('Impossible de charger le PDF');
        }
      },
      mimeType: 'application/pdf',
      widgetSize: taille,
      decoration: WidgetDecoration(
        backgroundColor: Colors.grey[200],
        iconColor: Colors.blue,
      ),
      errorBuilder: (context, error) {
        return Container(
          width: taille,
          height: taille,
          color: Colors.red[100],
          child: Center(
            child: Icon(Icons.error, color: Colors.red),
          ),
        );
      },
    );
  }
}
