import '../../core/di/di.dart';
import '../../data/repository/avis_client_repository_impl.dart';
import '../../data/repository/evenement_repository_impl.dart';
import 'fetch_avis_clients_data_usecase.dart';
import 'fetch_evenement_data_usecase.dart';


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
