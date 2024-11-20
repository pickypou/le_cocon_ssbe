import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/domain/entities/evenements.dart';

import '../evenement_interactor.dart';

class EvenementPage extends StatefulWidget {
  const EvenementPage({super.key});

  @override
  EvenementPageState createState() => EvenementPageState();
}

class EvenementPageState extends State<EvenementPage> {
  late Future<List<Evenement>> evenementsFuture;

  @override
  void initState() {
    super.initState();
    // Récupérer les événements en utilisant l'Interactor
    evenementsFuture = EvenementInteractor().fetchEvenements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Événements"),
      ),
      body: FutureBuilder<List<Evenement>>(
        future: evenementsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Aucun événement trouvé"));
          } else {
            final evenements = snapshot.data!;
            return ListView.builder(
              itemCount: evenements.length,
              itemBuilder: (context, index) {
                final evt = evenements[index];
                return ListTile(
                  title: Text(evt.title),
                  subtitle: Text(evt.publishDate.toString()),
                  leading: evt.thumbnailUrl != null
                      ? Image.network(evt.thumbnailUrl!, width: 50, height: 50)
                      : Image.network(evt.fileUrl!, width: 50, height: 50),
                  onTap: () {
                    // Actions sur l'événement
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
