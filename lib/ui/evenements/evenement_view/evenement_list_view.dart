import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/common/widget/text_custom.dart';
import 'package:le_cocon_ssbe/ui/evenements/event_handler.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';
import '../../../domain/entities/evenements.dart';
import '../evenement_interactor.dart';

class EvenementListView extends StatefulWidget {
  const EvenementListView({super.key});

  @override
  EvenementListViewState createState() => EvenementListViewState();
}

class EvenementListViewState extends State<EvenementListView> {
  final EvenementInteractor _evenementInteractor = EvenementInteractor();
  List<Evenements> _evenements = [];
  bool _isLoading = true;
  String? _errorMessage;
  final EventHandler eventHandler = EventHandler();

  @override
  void initState() {
    super.initState();
    _loadEvenements();
  }

  Future<void> _loadEvenements() async {
    try {
      List<Evenements> evenements = await _evenementInteractor.fetchEvenements();
      setState(() {
        _evenements = evenements;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Erreur lors de la récupération des événements';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage!, style: TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: _loadEvenements,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }

    if (_evenements.isEmpty) {
      return const Center(child: Text("Aucun événement disponible"));
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
                child: CustomText(
                  phrase:"Nos, Evénements",

                ),
              ),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: _evenements.map((evt) {
                  return SizedBox(
                    width: cardWidth,
                    child: Card(
                      elevation: 4,
                      child: InkWell(
                        onTap: ()
                          => eventHandler.handleDocumentTap(
                            context,
                            evt.fileUrl!,
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
                              child: Icon(Icons.picture_as_pdf, color: Colors.white),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    evt.title.isNotEmpty ? evt.title : "Sans titre",
                                    style: textStyleText(context),
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
