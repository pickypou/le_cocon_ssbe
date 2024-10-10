

import 'package:le_cocon_ssbe/data/domain/entities/avis_clients/avis_clients.dart';

abstract class AvisClientsListState {}

class AvisClientsListSignUpLoadingState extends AvisClientsListState {}

class AvisClientsListSignUpLoadedState extends AvisClientsListState {
  final List<AvisClients> avisClientsData;
  AvisClientsListSignUpLoadedState({required this.avisClientsData});
}

class AvisClientsListSignUpErrorState extends AvisClientsListState {
  final String massage;
  AvisClientsListSignUpErrorState({required this.massage});

}