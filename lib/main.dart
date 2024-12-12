import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'core/di/di.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'core/router/router_config.dart';
import 'data/repository/repository_module.dart';
import 'domain/usecases/usecase_module.dart';
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

  setupUseCaseModule(); // Appel pour enregistrer les cas d'utilisation
  setupRepositoryModule();

  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouterConfig = getIt<AppRouterConfig>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Le cocon s.s.b.e',
      theme: theme.copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: appRouterConfig.router,
    );
  }
}
