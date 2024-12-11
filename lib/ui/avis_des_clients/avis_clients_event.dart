import 'package:equatable/equatable.dart';

abstract class AvisClientsEvent extends Equatable {


  @override
  List<Object> get props => [];
}
class AddAvisClientsSignUpEvent extends AvisClientsEvent {
  final String id;
  final String categories;
  final String text;
  final String firstname;
  final DateTime publishDate;
  final Function navigateToAccount;

  AddAvisClientsSignUpEvent({
    required this.id,
    required this.categories,
    required this.text,
    required this.firstname,
    required this.publishDate,
    required this.navigateToAccount,
  });
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


