import '../../core/di/di.dart';
import 'avis_clients.dart';
import 'evenements.dart';


void setupEntityModule() {
  getIt.registerFactory<AvisClients>(() =>
      AvisClients(
        id: '', // Provide a default or generate a unique ID
        categories: '', // Provide default categories or an empty list
        text: '', // Provide a default text
        firstname: '', //Provide a default firstname
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
