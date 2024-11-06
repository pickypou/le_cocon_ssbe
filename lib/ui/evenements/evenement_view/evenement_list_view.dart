import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

import '../../../domain/entities/evenements.dart';
import '../event_handler.dart';

class EvenementListView extends StatelessWidget {
  final List<Evenements> evenement;
  final EventHandler eventHandler =
      EventHandler(); // Instanciez correctement EventHandler

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  EvenementListView({super.key, required this.evenement});

  Future<void> fetchEventFiles(String evenementId) async {
    try {
      // Récupérer l'URL du fichier PDF
      String fileUrl = await _firebaseStorage
          .ref()
          .child('evenement/$evenementId/file.pdf')
          .getDownloadURL();
      // Récupérer l'URL de la vignette
      String thumbnailUrl = await _firebaseStorage
          .ref()
          .child('evenement/$evenementId/thumbnail.jpg')
          .getDownloadURL();

      debugPrint("URL du fichier PDF : $fileUrl");
      debugPrint("URL de la vignette : $thumbnailUrl");

      // Mettez à jour l'événement avec l'URL de la vignette et du fichier
      // Par exemple, vous pouvez créer une méthode pour mettre à jour la liste des événements avec ces URLs.
    } catch (e) {
      debugPrint("Erreur lors de la récupération des fichiers : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (evenement.isEmpty) {
      return Center(child: Text("Aucun événement disponible"));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth / 4.5).clamp(200.0, 400.0);
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  "Nos événements",
                  style: titleStyleMedium(context),
                ),
              ),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: evenement.map((evt) {
                  fetchEventFiles(evt.id);

                  return SizedBox(
                    width: cardWidth,
                    child: Card(
                      elevation: 4,
                      child: InkWell(
                        onTap: () => eventHandler.handleDocumentTap(
                          context,
                          evt.fileUrl,
                          evt.title,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            evt.thumbnailUrl != null
                                ? Image.network(evt.thumbnailUrl!)
                                : Container(
                                    height: 100,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.picture_as_pdf,
                                        color: Colors.white),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    evt.title.isNotEmpty
                                        ? evt.title
                                        : "Sans titre",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    evt.formattedPublishDate,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
