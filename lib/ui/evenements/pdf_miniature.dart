import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:path_provider/path_provider.dart';
import '../../services/network_service.dart';

class PdfMiniature extends StatefulWidget {
  final String pdfUrl;
  final double height;
  final double width;
  final String fileName;

  const PdfMiniature({
    super.key,
    required this.pdfUrl,
    this.height = 150,
    this.width = double.infinity, required this.fileName,
  });

  @override
  PdfMiniatureState createState() => PdfMiniatureState();
}

class PdfMiniatureState extends State<PdfMiniature> {
  PdfDocument? _document;
  final NetworkService _networkService = NetworkService(); // Instanciez NetworkService

  @override
  void initState() {
    super.initState();
    _downloadAndLoadPdf();
  }

  Future<void> _downloadAndLoadPdf() async {
    try {
      // Utilisez le NetworkService pour télécharger le fichier PDF
      debugPrint("Téléchargement du PDF depuis : ${widget.pdfUrl}");
      final response = await _networkService.fetchPdf(widget.pdfUrl);
      if (response.statusCode == 200) {
        // Sauvegardez et chargez le fichier
        final tempDir = await getTemporaryDirectory();
        final localPath = '${tempDir.path}/${widget.pdfUrl.split('/').last}';
        final file = File(localPath);
        await file.writeAsBytes(response.bodyBytes);

        debugPrint("PDF sauvegardé à : $localPath");
        _document = await PdfDocument.openFile(localPath);

        setState(() {});
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
          return RawImage(image: snapshot.data!.imageIfAvailable);
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

