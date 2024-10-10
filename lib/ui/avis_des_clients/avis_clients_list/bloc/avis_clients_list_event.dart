import 'package:equatable/equatable.dart';

abstract class AvisClientsListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAvisClientsList extends AvisClientsListEvent {}

class FetchAvisClientsDetail extends AvisClientsListEvent {
  final String avisClientsId;
  FetchAvisClientsDetail(this.avisClientsId);

  @override
  List<Object> get props => [avisClientsId];
}