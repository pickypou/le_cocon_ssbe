import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di_module.config.dart';

final GetIt getIt = GetIt.instance;

@module
abstract class FirebaseModule {
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  @lazySingleton
  FirebaseStorage get storage => FirebaseStorage.instance;
}

@lazySingleton
class StorageService {
  final FirebaseStorage storage;

  StorageService(this.storage);
}

@lazySingleton
class FirestoreService {
  final FirebaseFirestore firestore;

  FirestoreService(this.firestore);
}

@InjectableInit(
  initializerName: 'initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
void configureDependencies() => initGetIt(getIt);
