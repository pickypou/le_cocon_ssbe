import 'package:equatable/equatable.dart';

abstract class AvisClientsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Événement pour charger la liste d'avis clients
class LoadAvisClientsEvent extends AvisClientsEvent {}

// Événement pour récupérer les détails d'un avis spécifique
class FetchAvisClientDetailEvent extends AvisClientsEvent {
  final String avisClientId;

  FetchAvisClientDetailEvent(this.avisClientId);

  @override
  List<Object> get props => [avisClientId];
}
