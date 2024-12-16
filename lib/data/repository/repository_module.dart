
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:le_cocon_ssbe/data/repository/evenements_repository.dart';
import 'package:le_cocon_ssbe/data/repository/evenement_repository_impl.dart';
import '../../core/di/di.dart';
import '../../core/di/api/firestore_service.dart';
import 'avis_client_repository_impl.dart';
import 'avis_clients_repository.dart';


void setupRepositoryModule() {
  getIt.registerLazySingleton<FirebaseFirestore>(() =>
  FirebaseFirestore.instance);

  // Pass the FirebaseFirestore instance to the FirestoreService
  getIt.registerLazySingleton<FirestoreService>(
          () => FirestoreService(getIt<FirebaseFirestore>())
  );

  getIt.registerLazySingleton<AvisClientsRepository>(
          () => AvisClientsRepositoryImpl(getIt<FirestoreService>())
  );

  getIt.registerLazySingleton<EvenementRepository>(
          () => EvenementRepositoryImpl()
  );
  getIt.registerLazySingleton<EvenementRepositoryImpl>(
          () => EvenementRepositoryImpl()
  );

}