import 'package:flutter/material.dart';
import '../../../domain/entities/evenements.dart';
import '../event_handler.dart';

class EvenementListView extends StatelessWidget {
  final List<Evenements> evenement;
  final EventHandler eventHandler = EventHandler();

  EvenementListView({super.key, required this.evenement});

  @override
  Widget build(BuildContext context) {
    if (evenement.isEmpty) {
      return Center(child: Text("Aucun événement disponible"));
    }

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
                  SizedBox(width: totalWidth > constraints.maxWidth
                      ? 0
                      : (constraints.maxWidth - totalWidth) / 2),
                  ...evenement.map((evt) => Padding(
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
                                child: eventHandler.buildThumbnail(evt), // Utilisation de buildThumbnail
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
                  )),
                  SizedBox(width: totalWidth > constraints.maxWidth
                      ? 0
                      : (constraints.maxWidth - totalWidth) / 2),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
