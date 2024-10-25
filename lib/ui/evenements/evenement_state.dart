import 'package:le_cocon_ssbe/domain/entities/evenements.dart';

abstract class EvenementState {}

// État initial, indique que le chargement est en cours
class EvenementLoadingState extends EvenementState {}

// État lorsque la liste d'avis clients est chargée avec succès
class EvenementLoadedState extends EvenementState {
  final List<Evenements> evenementData;

  EvenementLoadedState({required this.evenementData});
}

// État lorsque le chargement d'un avis client spécifique est réussi
class EvenementDetailLoadedState extends EvenementState {
  final Evenements evenementDetail;

  EvenementDetailLoadedState({required this.evenementDetail});
}

// État lorsqu'une erreur survient
class EvenementErrorState extends EvenementState {
  final String message;

  EvenementErrorState({required this.message});
}
