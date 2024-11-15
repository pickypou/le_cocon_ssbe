import 'package:get_it/get_it.dart';

import 'avis_clients.dart';
import 'evenements.dart';

final GetIt getIt = GetIt.instance;

void setupEntityModule() {
  getIt.registerFactory<AvisClients>(() =>
      AvisClients(
        id: '', // Provide a default or generate a unique ID
        categories: '', // Provide default categories or an empty list
        text: '', // Provide a default text
        publishDate: DateTime.now(), // Use current date as default
      ));

  //Register evenements
  getIt.registerFactory<Evenement>(() =>
      Evenement(
        id: '',
        title: '',
        fileType: '',
        fileUrl: '',
        thumbnailUrl: '',
        publishDate: DateTime.now(),
      ));
}
