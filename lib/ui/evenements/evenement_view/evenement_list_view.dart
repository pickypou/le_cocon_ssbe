import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import '../../../domain/entities/evenements.dart';
import '../../theme.dart';

class EvenementListView extends StatelessWidget {
  final List<Evenements> evenement;

  const EvenementListView({super.key, required this.evenement});

  Future<void> _openDocument(BuildContext context, Evenements evt) async {
    final url = evt.fileUrl;
    print("Tentative d'ouverture du document: $url"); // Log pour déboguer

    if (url.startsWith('http')) {
      // URL distante
      try {
        final uri = Uri.parse(url);
        final response = await http.get(uri);
        final bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final tempDocumentPath = '${tempDir.path}/${evt.title}.${_getFileExtension(url)}';
        File(tempDocumentPath).writeAsBytesSync(bytes);
        print("Fichier téléchargé et sauvegardé: $tempDocumentPath"); // Log pour déboguer
        _openFile(context, tempDocumentPath, evt.title);
      } catch (e) {
        print("Erreur lors du téléchargement: $e"); // Log pour déboguer
        _showErrorDialog(context, "Impossible de télécharger le document: $e");
      }
    } else {
      // URL locale
      print("Tentative d'ouverture du fichier local: $url"); // Log pour déboguer
      _openFile(context, url, evt.title);
    }
  }

  void _openFile(BuildContext context, String filePath, String title) {
    print("Ouverture du fichier: $filePath"); // Log pour déboguer
    if (_isImageFile(filePath)) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DocumentViewerPage(
            title: title,
            filePath: filePath,
            isImage: true,
          ),
        ),
      );
    } else {
      OpenFile.open(filePath).then((result) {
        print("Résultat de l'ouverture: ${result.type}, ${result.message}"); // Log pour déboguer
        if (result.type != ResultType.done) {
          _showErrorDialog(context, "Impossible d'ouvrir le fichier: ${result.message}");
        }
      });
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    print("Affichage de l'erreur: $message"); // Log pour déboguer
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

  String _getFileExtension(String url) {
    return url.split('.').last.toLowerCase();
  }

  bool _isImageFile(String url) {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
    return imageExtensions.contains(_getFileExtension(url));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
          builder: (context, constraints) {
            final cardWidth = constraints.maxWidth / 4.5;
            final totalWidth = cardWidth * evenement.length;

            return Container(
              height: 300,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: totalWidth > constraints.maxWidth ? 0 : (constraints.maxWidth - totalWidth) / 2),
                    ...evenement.map((evt) =>
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                            width: cardWidth,
                            child: GestureDetector(
                              onTap: () => _openDocument(context, evt),
                              child: Card(
                                elevation: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: _getImageProvider(evt.fileUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Center(
                                        child: Icon(
                                          _isImageFile(evt.fileUrl) ? Icons.image : Icons.picture_as_pdf,
                                          size: 50,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            evt.title,
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            evt.formattedPublishDate,
                                            style: TextStyle(color: Colors.grey[600]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                    ).toList(),
                    SizedBox(width: totalWidth > constraints.maxWidth ? 0 : (constraints.maxWidth - totalWidth) / 2),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }

  ImageProvider _getImageProvider(String url) {
    if (url.startsWith('http')) {
      return NetworkImage(url);
    } else {
      return FileImage(File(url));
    }
  }
}

class DocumentViewerPage extends StatelessWidget {
  final String title;
  final String filePath;
  final bool isImage;

  const DocumentViewerPage({
    Key? key,
    required this.title,
    required this.filePath,
    required this.isImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: isImage
          ? PhotoView(
        imageProvider: FileImage(File(filePath)),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
      )
          : Center(
        child: Text("Ce fichier n'est pas une image et ne peut pas être affiché ici."),
      ),
    );
  }
}