import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:photo_view/photo_view.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../../domain/entities/evenements.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

class EvenementListView extends StatelessWidget {
  final List<Evenements> evenement;

  const EvenementListView({Key? key, required this.evenement}) : super(key: key);

  Future<void> _handleDocumentTap(BuildContext context, Evenements evt) async {
    if (kIsWeb) {
      await _launchURL(evt.fileUrl);
    } else {
      try {
        final file = await _downloadFile(evt.fileUrl, evt.title);
        if (file != null) {
          if (_isImageFile(evt.fileUrl)) {
            _showEnlargedImage(context, file, evt.title);
          } else {
            _openPdfFile(context, file, evt.title);
          }
        }
      } catch (e) {
        print("Erreur lors du téléchargement: $e");
        _showErrorDialog(context, "Impossible de télécharger le document: $e");
      }
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<File?> _downloadFile(String url, String fileName) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/${fileName.isNotEmpty ? fileName : "document"}.${_getFileExtension(url)}');
        await file.writeAsBytes(bytes);
        print("File downloaded successfully: ${file.path}");
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

  String _getFileExtension(String url) {
    return url.split('.').last.split('?').first.toLowerCase();
  }

  bool _isImageFile(String url) {
    final imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'bmp'];
    return imageExtensions.contains(_getFileExtension(url));
  }

  Widget _buildThumbnail(Evenements evt) {
    print("Building thumbnail for: ${evt.title}, URL: ${evt.fileUrl}");
    if (_isImageFile(evt.fileUrl)) {
      return CachedNetworkImage(
        imageUrl: evt.fileUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) {
          print("Error loading image: $error");
          return Center(child: Icon(Icons.error));
        },
      );
    } else {
      return Center(
        child: Icon(
          Icons.picture_as_pdf,
          size: 50,
          color: Colors.grey,
        ),
      );
    }
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
                              onTap: () => _handleDocumentTap(context, evt),
                              child: Card(
                                elevation: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 150,
                                      child: _buildThumbnail(evt),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            evt.title.isNotEmpty ? evt.title : "Sans titre",
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
}