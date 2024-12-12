import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_cocon_ssbe/ui/avis_des_clients/avis_clients_interactor.dart';
import '../../domain/entities/avis_clients.dart';
import 'avis_clients_event.dart';
import 'avis_clients_state.dart';

class AvisClientsBloc extends Bloc<AvisClientsEvent, AvisClientsState> {
  final AvisClientsInteractor avisClientsInteractor;

  AvisClientsBloc(this.avisClientsInteractor)
      : super(AvisClientsLoadingState()) {
    // Gestion de l'événement pour charger les avis
    on<LoadAvisClientsEvent>((event, emit) async {
      emit(AvisClientsLoadingState());
      try {
        final avisClients = await avisClientsInteractor.fetchAvisClientsData();
        emit(AvisClientsLoadedState(avisClientsData: avisClients.toList()));
      } catch (e) {
        emit(AvisClientsErrorState(message: 'Erreur lors du chargement : $e'));
      }
    });

    // Gestion de l'événement pour ajouter un avis
    on<AddAvisClientEvent>((event, emit) async {
      try {
        emit(AvisClientsLoadingState());

        // Crée l'avis client
        final avisClient = AvisClients(
          id: event.id,
          firstname: event.firstname,
          text: event.text,
          publishDate: event.publishDate,
          categories: event.categories,
        );

        // Appelle l'interactor pour ajouter l'avis
        await avisClientsInteractor.addAvisClients(avisClient);

        // Recharge les avis clients
        final updatedAvisClients = await avisClientsInteractor.fetchAvisClientsData();

        // Émet un état de succès
        emit(AvisClientsLoadedState(avisClientsData: updatedAvisClients.toList()));

        // Navigation après succès
        event.navigateToAccount();
      } catch (e) {
        emit(AvisClientsErrorState(message: 'Erreur lors de l\'ajout : $e'));
      }
    });

  }
}
