import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdfx/pdfx.dart';
import '../../domain/entities/evenements.dart';
import 'package:flutter/material.dart';

import 'evenement_view/evenement_helpers.dart';

class EventHandler {
  Future<void> handleDocumentTap(BuildContext context, String fileUrl, String title) async {
    if (kIsWeb) {
      await _launchURL(fileUrl);
    } else {
      try {
        final file = await _downloadFile(fileUrl, title);
        if (file != null) {
          if (_isImageFile(fileUrl)) {
            _showEnlargedImage(context, file, title);
          } else if (_isPdfFile(fileUrl)) {
            _openPdfFile(context, file, title);
          } else {
            _showErrorDialog(context, "Type de fichier non pris en charge.");
          }
        }
      } catch (e) {
        _showErrorDialog(context, "Impossible de télécharger le document: $e");
      }
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<File?> _downloadFile(String url, String fileName) async {
    // Ajoutez votre code de téléchargement ici
    return null; // Placeholder
  }

  void _showEnlargedImage(BuildContext context, File file, String title) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(title.isNotEmpty ? title : "Image")),
          body: PhotoView(
            imageProvider: FileImage(file),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ),
      ),
    );
  }

  void _openPdfFile(BuildContext context, File file, String title) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(title.isNotEmpty ? title : "PDF")),
          body: PDFView(
            filePath: file.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: false,
            onError: (error) {
              print(error.toString());
            },
            onPageError: (page, error) {
              print('$page: ${error.toString()}');
            },
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Erreur"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool _isImageFile(String url) {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
    return imageExtensions.contains(_getFileExtension(url));
  }

  bool _isPdfFile(String url) {
    return _getFileExtension(url) == 'pdf';
  }

  String _getFileExtension(String url) {
    return url.split('.').last.split('?').first.toLowerCase();
  }

  // Vous pouvez rendre cette méthode publique pour l'utiliser dans d'autres fichiers
  Widget buildThumbnail(Evenements evt) {
    if (evt.fileUrl.isEmpty) {
      return Container(
        color: Colors.grey,
        child: Center(child: Text("Aperçu non disponible")),
      );
    }

    if (_isImageFile(evt.fileUrl)) {
      return CachedNetworkImage(
        imageUrl: evt.fileUrl,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      );
    } else if (_isPdfFile(evt.fileUrl)) {
      // Utilisation de pdf_thumbnail pour générer une miniature
      return FutureBuilder<Image?>(
        future: generatePdfThumbnail(evt.fileUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.red,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Container(
              color: Colors.red,
              child: Center(child: Text("Erreur de miniature")),
            );
          } else {
            return snapshot.data ?? Container();
          }
        },
      );
    }

    return Container(
      color: Colors.red,
      child: Center(child: Text("Type de fichier non pris en charge")),
    );
  }



}
