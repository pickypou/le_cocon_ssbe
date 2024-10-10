import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/data/domain/entities/avis_clients/avis_clients.dart';
import 'package:le_cocon_ssbe/ui/avis_des_clients/add_avis_clients/bloc/avis_clients_event.dart';
import 'package:le_cocon_ssbe/ui/avis_des_clients/interactor/avis_clients_interactor.dart';

import 'avis_clients_state.dart';

class AddAvisClientsBloc extends Bloc<AddAvisClientsEvent, AddAvisClientsState> {
 final AvisClientsInteractor avisClientsInteractor;

 AddAvisClientsBloc(this.avisClientsInteractor)
  : super(AddAvisClientsSignUpInitialState()) {
   on<AddAvisClientsEvent>((event, emit) async {
     if(event is AddAvisClientsSignUpEvent) {
       emit(AddAvisClientsSignUpLoadingState());
       try {
         debugPrint('publishDate avant conversion: ${event.publishDate}');

         //Convertir publishDate
         DateTime parsedPublishDate = DateTime.parse(event.publishDate.toString());
         debugPrint('publishDate après conversion: ${event.publishDate}');

         final avisClients = AvisClients(
             id: event.id,
             categories: event.categories,
             text: event.text,
             publishDate: event.publishDate
         );
         await avisClientsInteractor.addAvisClients(avisClients);
         emit(AddAvisClientsSignUpSuccessState(addAvisClientsId: event.id));
       }catch(error) {
         emit(AddAvisClientsSignUpErrorState(error.toString()));
       }
     }
   });
 }
}