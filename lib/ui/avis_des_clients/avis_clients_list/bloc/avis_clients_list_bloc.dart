import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:le_cocon_ssbe/ui/avis_des_clients/interactor/avis_clients_interactor.dart';
import 'avis_client_list_state.dart';
import 'avis_clients_list_event.dart';

class AvisClientsListBloc extends Bloc<AvisClientsListEvent, AvisClientsListState> {
  final AvisClientsInteractor avisClientsInteractor;
  final String avisClientId;

  AvisClientsListBloc(this.avisClientsInteractor, this.avisClientId)
      : super(AvisClientsListSignUpLoadingState());

  @override
  Stream<AvisClientsListState> mapEventToState(AvisClientsListEvent event) async*{
    if (event is LoadAvisClientsList) {
      yield AvisClientsListSignUpLoadingState();

      try {
        // Appel de la méthode d'instance avisClientsInteractor.fetchAvisClientsData
        final avisClients = await avisClientsInteractor.fetchAvisClientsData();

        // Convertir Iterable en List
        final avisClientsList = avisClients.toList();

        // Émettre l'état avec les données chargées
        yield AvisClientsListSignUpLoadedState(avisClientsData: avisClientsList);
      } catch (e) {
        yield AvisClientsListSignUpErrorState(
          massage: 'Une erreur s\'est produite : $e',
        );
      }
    }
  }
}
