// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/repository/avis_client_repository_impl.dart' as _i891;
import '../../data/repository/avis_clients_repository.dart' as _i990;
import '../../data/repository/evenement_repository_impl.dart' as _i1053;
import '../../domain/usecases/fetch_avis_clients_data_usecase.dart' as _i57;
import '../../domain/usecases/fetch_evenement_data_usecase.dart' as _i914;
import '../../ui/avis_des_clients/avis_clients_interactor.dart' as _i3;
import '../../ui/avis_des_clients/avis_clients_module.dart' as _i1016;
import '../../ui/ui_module.dart' as _i573;
import '../../ui/view_all/view_all_module.dart' as _i261;
import '../router/router_config.dart' as _i718;
import 'api/firestore_service.dart' as _i746;
import 'di_module.dart' as _i211;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt init(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final firebaseModule = _$FirebaseModule();
  gh.singleton<_i573.AppRouter>(() => _i573.AppRouter());
  gh.singleton<_i718.AppRouterConfig>(() => _i718.AppRouterConfig());
  gh.singleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.singleton<_i457.FirebaseStorage>(() => firebaseModule.storage);
  gh.factory<_i1053.EvenementRepositoryImpl>(() =>
      _i1053.EvenementRepositoryImpl(firestore: gh<_i974.FirebaseFirestore>()));
  gh.factory<_i914.FetchEvenementDataUseCase>(() =>
      _i914.FetchEvenementDataUseCase(gh<_i1053.EvenementRepositoryImpl>()));
  gh.factory<_i746.FirestoreService>(
      () => _i746.FirestoreService(gh<_i974.FirebaseFirestore>()));
  gh.singleton<_i1016.AddAvisClientsModule>(
      () => _i1016.AddAvisClientsModule(gh<_i573.AppRouter>()));
  gh.singleton<_i261.ViewAllModule>(
      () => _i261.ViewAllModule(gh<_i573.AppRouter>()));
  gh.factory<_i990.AvisClientsRepository>(
      () => _i891.AvisClientsRepositoryImpl(gh<_i746.FirestoreService>()));
  gh.factory<_i57.FetchAvisClientDataUseCase>(
      () => _i57.FetchAvisClientDataUseCase(gh<_i990.AvisClientsRepository>()));
  gh.singleton<_i3.AvisClientsInteractor>(() => _i3.AvisClientsInteractor(
        gh<_i57.FetchAvisClientDataUseCase>(),
        gh<_i990.AvisClientsRepository>(),
      ));
  return getIt;
}

class _$FirebaseModule extends _i211.FirebaseModule {}
