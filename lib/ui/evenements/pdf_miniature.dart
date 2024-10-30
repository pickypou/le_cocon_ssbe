import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';
import 'dart:typed_data'; // Assurez-vous d'avoir cette ligne seule pour Uint8List

class PdfMiniature extends StatefulWidget {
  final String pdfUrl;

  const PdfMiniature({super.key, required this.pdfUrl});

  @override
  _PdfMiniatureState createState() => _PdfMiniatureState();
}

class _PdfMiniatureState extends State<PdfMiniature> {
  late PdfController _pdfController;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    loadPDF();
  }

  Future<void> loadPDF() async {
    try {
      print('Début du téléchargement du PDF à partir de: ${widget.pdfUrl}');
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        final Uint8List data = response.bodyBytes;

        _pdfController = PdfController(
          document: PdfDocument.openData(data),
        );

        setState(() {
          _loading = false;
        });
      } else {
        print('Erreur lors du téléchargement du PDF: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors du téléchargement du PDF: $e');
      // Ajoutez des informations supplémentaires sur l'erreur
      if (e is http.ClientException) {
        print('Erreur Client: ${e.message}');
      } else {
        print('Erreur inconnue: ${e.toString()}');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(child: CircularProgressIndicator())
        : PdfView(
      controller: _pdfController,
      scrollDirection: Axis.horizontal,
      onPageChanged: (int page) {
        print('Page $page affichée');
      },
    );
  }
}
