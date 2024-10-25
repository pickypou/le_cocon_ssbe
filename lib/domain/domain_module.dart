import 'package:get_it/get_it.dart';
import 'package:le_cocon_ssbe/domain/usecases/usecase_module.dart';

import 'entities/entity_module.dart';

final GetIt getIt = GetIt.instance;

void setupDomainModule() {
  // Setup des entités
  setupEntityModule();

  //Setupt des Use Case

  setupUseCaseModule();
}
