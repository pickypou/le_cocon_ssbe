import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';
import '../../../domain/entities/evenements.dart';
import '../event_handler.dart';
import '../pdf_miniature.dart';

class EvenementListView extends StatelessWidget {
  final List<Evenements> evenement;
  final EventHandler eventHandler = EventHandler();

  EvenementListView({super.key, required this.evenement});

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
                  style:titleStyleMedium(context)
                  
                ),
              ),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: evenement.map((evt) {
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
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: evt.fileType == 'pdf'
                                  ? PdfMiniature(pdfUrl: evt.fileUrl, fileName: '',)
                                  : Image.network(
                                evt.fileUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey[200],
                                    child: Center(
                                      child: Text(
                                        'Aperçu indisponible',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    evt.title.isNotEmpty ? evt.title : "Sans titre",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
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