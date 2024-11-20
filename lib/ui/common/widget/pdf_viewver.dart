import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PDFViewerPage extends StatefulWidget {
  const PDFViewerPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PdfController pdfController;

  @override
  void initState() {
    super.initState();
    pdfController = PdfController(
      document: PdfDocument.openAsset('assets/pdf/mention_legal.pdf'),
    );
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mention légale')),
      body: PdfView(
        controller: pdfController,
        scrollDirection: Axis.vertical, // Défilement vertical
        pageSnapping: false, // Désactive le "snap" pour un défilement fluide
      ),
    );
  }
}