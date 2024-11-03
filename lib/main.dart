import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';
import 'package:le_cocon_ssbe/ui/view_all/wiew_all.dart';
import 'package:path_provider/path_provider.dart';

import 'firebase_options.dart';

Future<String> getDirectoryPath() async {
  if (kIsWeb) {
    // Gérer les chemins de manière différente pour le web
    return '/path/to/web/directory'; // Définir un chemin approprié
  } else {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:
        DefaultFirebaseOptions.currentPlatform, // Utilisez les options générées
  );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Le cocon s.s.b.e',
      theme: theme.copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ViewAll(),
    );
  }
}
