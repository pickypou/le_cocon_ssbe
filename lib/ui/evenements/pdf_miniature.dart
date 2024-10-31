import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class PdfMiniature extends StatefulWidget {
  final String pdfUrl;
  final double height;
  final double width;

  const PdfMiniature({
    Key? key,
    required this.pdfUrl,
    this.height = 150,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  _PdfMiniatureState createState() => _PdfMiniatureState();
}

class _PdfMiniatureState extends State<PdfMiniature> {
  PdfDocument? _document;

  @override
  void initState() {
    super.initState();
    _downloadAndLoadPdf();
  }
  String _getFileNameFromUrl(String url) {
    // Extraire le nom du fichier de l'URL
    return url.split('/').last.split('?')[0];
  }


  Future<void> _downloadAndLoadPdf() async {
    try {
      // 1. Télécharger le fichier PDF depuis Firebase Storage
      debugPrint("Téléchargement du PDF depuis : ${widget.pdfUrl}");
      final response = await http.get(Uri.parse(widget.pdfUrl));
      if (response.statusCode == 200) {
        // 2. Extraire le nom du fichier à partir de l'URL
        final fileName = _getFileNameFromUrl(widget.pdfUrl);
        debugPrint("Nom du fichier extrait : $fileName"); // Afficher le nom du fichier extrait

        // 3. Sauvegarder le fichier PDF dans un répertoire temporaire
        final tempDir = await getTemporaryDirectory();
        final localPath = '${tempDir.path}/$fileName'; // Utiliser le nom d'origine
        final file = File(localPath);
        await file.writeAsBytes(response.bodyBytes);

        debugPrint("PDF sauvegardé à : $localPath"); // Afficher le chemin de sauvegarde

        // 4. Charger le document PDF depuis le fichier local
        _document = await PdfDocument.openFile(localPath);

        setState(() {
          // Mise à jour pour indiquer que le fichier est prêt
        });
      } else {
        debugPrint("Erreur de téléchargement du PDF : ${response.statusCode}");
      }
    } catch (e) {
      debugPrint('Erreur lors du téléchargement ou du chargement du PDF : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _document == null
        ? Center(child: CircularProgressIndicator())
        : FutureBuilder<PdfPageImage?>(
      future: _document!.getPage(1).then((page) => page.render(
        width: widget.width.toInt(),
        height: widget.height.toInt(),
      )),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return Icon(Icons.error, color: Colors.red);
        } else {
          return snapshot.data!.imageIfAvailable != null
              ? RawImage(image: snapshot.data!.imageIfAvailable)
              : Icon(Icons.error, color: Colors.red);
        }
      },
    );
  }

  @override
  void dispose() {
    _document?.dispose();
    super.dispose();
  }
}
