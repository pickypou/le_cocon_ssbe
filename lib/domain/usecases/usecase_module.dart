import 'package:get_it/get_it.dart';

import '../../data/repository/avis_client_repositoryImpl.dart';
import '../../data/repository/evenementRepositoryImpl.dart';
import 'fetch_avis_clients_data_usecase.dart';
import 'fetch_evenement-data-usecase.dart';

final GetIt getIt = GetIt.instance;

void setupUseCaseModule() {
  // Enregistrement du cas d'utilisation FetchAvisClientsDataUseCase
  getIt.registerLazySingleton<FetchAvisClientDataUseCase>(
      () => FetchAvisClientDataUseCase(getIt<AvisClientsRepositoryImpl>()));

  if (getIt.isRegistered<FetchEvenementDataUseCase>()) {
    getIt.unregister<FetchEvenementDataUseCase>();
  }
  // Enregistrement du cas d'utilisation FetchEvenementDataUseCase
  getIt.registerLazySingleton<FetchEvenementDataUseCase>(
      () => FetchEvenementDataUseCase(getIt<EvenementRepositoryImpl>()));
}
