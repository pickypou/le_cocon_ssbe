import 'package:equatable/equatable.dart';

abstract class EvenementEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Événement pour charger la liste d'avis clients
class LoadAEvenementEvent extends EvenementEvent {}

// Événement pour récupérer les détails d'un avis spécifique
class FetchEvenementDetailEvent extends EvenementEvent {
  final String evenementId;

  FetchEvenementDetailEvent(this.evenementId);

  @override
  List<Object> get props => [evenementId];
}
