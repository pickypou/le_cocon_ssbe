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

import '../../data/repository/avis_client_repository_impl.dart' as _i993;
import '../../data/repository/avis_clients_repository.dart' as _i990;
import '../../data/repository/evenements_repository.dart' as _i554;
import '../../data/repository/evenement_repository_impl.dart' as _i284;
import '../../domain/usecases/fetch_avis_clients_data_usecase.dart' as _i57;
import '../../domain/usecases/fetch_evenement_data_usecase.dart' as _i545;
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
  gh.lazySingleton<_i974.FirebaseFirestore>(() => firebaseModule.firestore);
  gh.lazySingleton<_i457.FirebaseStorage>(() => firebaseModule.storage);
  gh.lazySingleton<_i211.StorageService>(
      () => _i211.StorageService(gh<_i457.FirebaseStorage>()));
  gh.factory<_i993.AvisClientsRepositoryImpl>(() =>
      _i993.AvisClientsRepositoryImpl(
          firestore: gh<_i974.FirebaseFirestore>()));
  gh.factory<_i284.EvenementRepositoryImpl>(() =>
      _i284.EvenementRepositoryImpl(firestore: gh<_i974.FirebaseFirestore>()));
  gh.factory<_i545.FetchEvenementDataUseCase>(
      () => _i545.FetchEvenementDataUseCase(gh<_i554.EvenementRepository>()));
  gh.factory<_i57.FetchAvisClientDataUseCase>(
      () => _i57.FetchAvisClientDataUseCase(gh<_i990.AvisClientsRepository>()));
  gh.lazySingleton<_i211.FirestoreService>(
      () => _i211.FirestoreService(gh<_i974.FirebaseFirestore>()));
  gh.factory<_i746.FirestoreService>(
      () => _i746.FirestoreService(gh<_i974.FirebaseFirestore>()));
  return getIt;
}

class _$FirebaseModule extends _i211.FirebaseModule {}
