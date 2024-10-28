import 'dart:typed_data';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:flutter/material.dart';

Future<File?> downloadFile(String url, String fileName) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/${fileName.isNotEmpty ? fileName : "document"}.${getFileExtension(url)}');
      await file.writeAsBytes(bytes);
      return file;
    }
  } catch (e) {
    print("Erreur lors du téléchargement: $e");
  }
  return null;
}

String getFileExtension(String url) {
  return url.split('.').last.split('?').first.toLowerCase();
}

bool isImageFile(String url) {
  final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
  return imageExtensions.contains(getFileExtension(url));
}

bool isPdfFile(String url) {
  return getFileExtension(url) == 'pdf';
}

Future<Image?> generatePdfThumbnail(String pdfUrl) async {
  try {
    final file = await downloadFile(pdfUrl, "thumbnail.pdf");
    if (file == null) return null;

    final document = await PdfDocument.openFile(file.path);
    final page = await document.getPage(1); // Obtenir la première page

    final image = await page.render(
      width: page.width.toDouble(), // Taille de l'image
      height: page.height.toDouble(),
    );

    await page.close();
    await document.close();

    return Image.memory(Uint8List.fromList(image!.bytes));
  } catch (e) {
    print("Erreur lors de la génération de la vignette : $e");
    return null;
  }

}

