import 'package:equatable/equatable.dart';

// Classe abstraite de base pour tous les événements liés aux avis clients
abstract class AvisClientsEvent extends Equatable {
  const AvisClientsEvent();

  @override
  List<Object?> get props => [];
}

// Événement pour charger la liste d'avis clients
class LoadAvisClientsEvent extends AvisClientsEvent {}

// Événement pour récupérer les détails d'un avis spécifique
class FetchAvisClientDetailEvent extends AvisClientsEvent {
  final String avisClientId;

  const FetchAvisClientDetailEvent(this.avisClientId);

  @override
  List<Object?> get props => [avisClientId];
}

// Événement pour ajouter un avis client
class AddAvisClientEvent extends AvisClientsEvent {
  final String id;
  final String firstname;
  final String text;
  final DateTime publishDate;
  final String categories;
  final Function navigateToAccount;


  const AddAvisClientEvent({
    required this.id,
    required this.firstname,
    required this.text,
    required this.publishDate,
    required this.categories,
    required this.navigateToAccount
  });

  @override
  List<Object?> get props => [firstname, text, publishDate, categories];
}
