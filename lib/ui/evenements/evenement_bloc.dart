import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_cocon_ssbe/ui/evenements/evenement_event.dart';
import 'package:le_cocon_ssbe/ui/evenements/evenement_interactor.dart';
import 'package:le_cocon_ssbe/ui/evenements/evenement_state.dart';

class EvenementBloc extends Bloc<EvenementEvent, EvenementState> {
  final EvenementInteractor evenementInteractor;

  EvenementBloc(this.evenementInteractor) : super(EvenementLoadingState()) {
    on<LoadAEvenementEvent>((event, emit) async {
      emit(EvenementLoadingState());
      try {
        // Appel de la méthode pour récupérer les événements
        final evenement = await evenementInteractor.fetchEvenementData();

        // Émettre l'état avec les données chargées
        emit(EvenementLoadedState(evenementData: evenement.toList()));
      } catch (e) {
        emit(EvenementErrorState(message: 'Une erreur s\'est produite : $e'));
      }
    });
  }
}
