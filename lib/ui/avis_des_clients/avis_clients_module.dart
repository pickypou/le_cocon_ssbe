import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:le_cocon_ssbe/ui/avis_des_clients/view/add_avis_clients.dart';
import '../../core/di/di.dart';

import '../ui_module.dart';
import 'avis_clients_bloc.dart';
import 'avis_clients_interactor.dart';

@singleton
class AddAvisClientsModule implements UIModule {
  final AppRouter _appRouter;

  AddAvisClientsModule(this._appRouter);

  @override
  void configure() {
    _appRouter.addRoutes(getRoutes());
  }

  @override
  List<RouteBase> getRoutes() {
    return [
      GoRoute(
          path: '/addAvisClients',
          pageBuilder: (context, state) {
            return MaterialPage(
              child: _buildAddAvisClients(),
            );
          })
    ];
  }

  @override
  Map<String, WidgetBuilder> getSharedWidgets() {
    return {};
  }

  Widget _buildAddAvisClients() {
    // Récupérer l'interactor via GetIt
    final interactor = getIt<AvisClientsInteractor>();

    return BlocProvider<AvisClientsBloc>(
      create: (context) => AvisClientsBloc(interactor), // Correction de la variable
      child: AddAvisClientsView(),
    );
  }
}
