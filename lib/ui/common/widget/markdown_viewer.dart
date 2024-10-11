import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Pour charger des fichiers
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

class MarkdownViewer extends StatelessWidget {
  final String filePath;

  const MarkdownViewer({super.key, required this.filePath});

  Future<String> loadMarkdown() async {
    // Charger le contenu du fichier Markdown
    return await rootBundle.loadString(filePath);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: loadMarkdown(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Pas de contenu disponible'));
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Markdown(
            data: snapshot.data!, // Afficher le Markdown
            styleSheet: getMDTheme(context), // Appliquer le thème
          ),
        );
      },
    );
  }
}
