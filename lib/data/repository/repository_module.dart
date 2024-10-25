


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:le_cocon_ssbe/data/repository/enements_repository.dart';
import 'package:le_cocon_ssbe/data/repository/evenementRepositoryImpl.dart';

import '../../core/di/api/firestore_service.dart';
import 'avis_client_repositoryImpl.dart';
import 'avis_clients_repository.dart';

final GetIt getIt = GetIt.instance;

void setupDataModule() {
  getIt.registerLazySingleton<FirebaseFirestore>(() =>
  FirebaseFirestore.instance);

  // Pass the FirebaseFirestore instance to the FirestoreService
  getIt.registerLazySingleton<FirestoreService>(
          () => FirestoreService(getIt<FirebaseFirestore>())
  );

  getIt.registerLazySingleton<AvisClientsRepository>(
          () => AvisClientsRepositoryImpl()
  );

  getIt.registerLazySingleton<EvenementRepository>(() => EvenementRepositoryImpl());
}