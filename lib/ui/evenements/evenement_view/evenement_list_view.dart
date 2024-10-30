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
    Size size = MediaQuery.sizeOf(context);
    if (evenement.isEmpty) {
      return Center(child: Text("Aucun événement disponible"));
    }

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Nos événements",
                style: titleStyleMedium(context).copyWith(fontSize: size.width / 10),
              ),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = constraints.maxWidth / 4.5;

              return Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: evenement.map((evt) {
                  // Ajoutez le print ici pour voir la valeur de pdfUrl
                  print('Valeur de pdfUrl pour ${evt.title}: ${evt.fileUrl}');

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: cardWidth,
                      child: GestureDetector(
                        onTap: () => eventHandler.handleDocumentTap(context, evt.fileUrl, evt.title),
                        child: Card(
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                child: evt.fileType == 'pdf'
                                    ? PdfMiniature(pdfUrl: evt.fileUrl) // Utilisation de PDFMiniature
                                    : Image.network(
                                  evt.fileUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Text(
                                        'Aperçu indisponible',
                                        style: TextStyle(color: Colors.red),
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
                                        color: Colors.black,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      evt.formattedPublishDate,
                                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
