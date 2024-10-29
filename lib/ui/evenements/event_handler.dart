import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:url_launcher/url_launcher.dart';

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
        } else {
          _showErrorDialog(context, "Impossible de télécharger le fichier.");
        }
      } catch (e) {
        _showErrorDialog(context, "Erreur lors du traitement du document: $e");
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
    try {
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/${fileName.isNotEmpty ? fileName : "document"}.${_getFileExtension(url)}');
        await file.writeAsBytes(bytes);
        return file;
      }
    } catch (e) {
      print("Erreur lors du téléchargement: $e");
    }
    return null;
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
}
