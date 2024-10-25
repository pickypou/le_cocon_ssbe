import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_cocon_ssbe/ui/avis_des_clients/avis_clients_interactor.dart';
import 'avis_clients_event.dart';
import 'avis_clients_state.dart';

class AvisClientsBloc extends Bloc<AvisClientsEvent, AvisClientsState> {
  final AvisClientsInteractor avisClientsInteractor;

  AvisClientsBloc(this.avisClientsInteractor)
      : super(AvisClientsLoadingState()) {
    on<LoadAvisClientsEvent>((event, emit) async {
      emit(AvisClientsLoadingState());
      try {
        // Appel de la méthode pour récupérer les avis
        final avisClients = await avisClientsInteractor.fetchAvisClientsData();

        // Émettre l'état avec les données chargées
        emit(AvisClientsLoadedState(avisClientsData: avisClients.toList()));
      } catch (e) {
        emit(AvisClientsErrorState(message: 'Une erreur s\'est produite : $e'));
      }
    });
  }
}
