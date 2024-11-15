import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_cocon_ssbe/ui/evenements/evenement_event.dart';
import 'package:le_cocon_ssbe/ui/evenements/evenement_interactor.dart';
import 'package:le_cocon_ssbe/ui/evenements/evenement_state.dart';

class EvenementBloc extends Bloc<EvenementEvent, EvenementState> {
  final EvenementInteractor evenementInteractor;

  EvenementBloc(this.evenementInteractor) : super(EvenementLoadingState()) {
    // Événement pour charger tous les événements
    on<LoadAEvenementEvent>((event, emit) async {
      emit(EvenementLoadingState());
      try {
        final evenement = await evenementInteractor.fetchEvenements();
        emit(EvenementLoadedState(evenementData: evenement.toList()));
      } catch (e) {
        emit(EvenementErrorState(message: 'Une erreur s\'est produite : $e'));
      }
    });

    // Événement pour récupérer un événement spécifique par ID
    on<FetchEvenementDetailEvent>((event, emit) async {
      emit(EvenementLoadingState());
      try {
        final evenementDetail =
        await evenementInteractor.fetchEvenementById(event.evenementId);
        if (evenementDetail != null) {
          emit(EvenementDetailLoadedState(evenementDetail: evenementDetail));
        } else {
          emit(EvenementErrorState(
              message: 'L\'événement avec cet ID n\'existe pas.'));
        }
      } catch (e) {
        emit(EvenementErrorState(message: 'Une erreur s\'est produite : $e'));
      }
    });
  }
}
