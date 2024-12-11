import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_cocon_ssbe/ui/avis_des_clients/avis_clients_interactor.dart';
import '../../domain/entities/avis_clients.dart';
import 'avis_clients_event.dart';
import 'avis_clients_state.dart';

class AvisClientsBloc extends Bloc<AvisClientsEvent, AvisClientsState> {
  final AvisClientsInteractor avisClientsInteractor;

  AvisClientsBloc(this.avisClientsInteractor)
      : super(AvisClientsLoadingState()) {
    on<AvisClientsEvent>((event, emit) async {
      try {
        // Optionnel : Vous pouvez émettre un état de chargement ici
        emit(AvisClientsLoadingState());

        // Créez un nouvel avis avec les données de l'événement
        final avisClient = AvisClients(
          id: DateTime.now().millisecondsSinceEpoch.toString(), // Génère un ID unique
          firstname: event.firstname,
          text: event.text,
          publishDate: event.publishDate,
          categories: event.categories,
        );

        // Ajoutez l'avis via l'interactor
        await avisClientsInteractor.addAvisClients(AvisClients as AvisClients);

        // Rechargez la liste après l'ajout
        final updatedAvisClients = await avisClientsInteractor.fetchAvisClientsData();

        // Émettre l'état avec les données mises à jour
        emit(AvisClientsLoadedState(avisClientsData: []));
      } catch (e) {
        emit(AvisClientsErrorState(message: 'Erreur lors de l\'ajout : $e'));
      }
    });



  }
}
