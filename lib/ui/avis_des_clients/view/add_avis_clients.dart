import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:le_cocon_ssbe/ui/common/widget/custom_appbar/custom_appbar.dart';
import 'package:le_cocon_ssbe/ui/common/widget/text_custom.dart';
import 'package:le_cocon_ssbe/ui/common/widget/custom_button.dart';
import 'package:le_cocon_ssbe/ui/common/widget/custom_text_field.dart';

import '../../theme.dart';
import '../avis_clients_bloc.dart';
import '../avis_clients_event.dart';
import '../avis_clients_state.dart';

class AddAvisClientsView extends StatefulWidget {
  const AddAvisClientsView({super.key});

  @override
  AddAvisClientsViewState createState() => AddAvisClientsViewState();
}

class AddAvisClientsViewState extends State<AddAvisClientsView> {
  final TextEditingController categoriesController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();

  @override
  void dispose() {
    categoriesController.dispose();
    textController.dispose();
    firstnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AvisClientsBloc, AvisClientsState>(
      listener: (context, state) {
        if (state is AvisClientsLoadedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Avis ajouté avec succès')),
          );
          // Utilisation de GoRouter pour rediriger vers la HomePage
          context.go('/');
        } else if (state is AvisClientsErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },

      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: GestureDetector(
              onTap: () {
                context.go('/'); // Navigue vers la route '/'
              },
              child: Text(
                'Accueil',
                style:  TextStyle(color: theme.colorScheme.onPrimary // Assurez-vous que le texte est visible
                ),
              ),
            ),
          ),

          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, AvisClientsState state) {
    if (state is AvisClientsLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child:
              CustomText(phrase: 'Je, Poste, Mon, Avis',   ) ,
              ),
              const SizedBox(height: 40),
              CustomTextField(
                labelText: 'Titre',
                controller: categoriesController,
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                  labelText: 'Nom et Prénom',
                  controller: firstnameController,
                  maxLines: 1
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Mon commentaire',
                controller: textController,
                maxLines: 5,
              ),
              const SizedBox(height: 24),
              CustomButton(
                onPressed: _submitAvis,
                label: 'Je poste mon avis',
              ),
            ],
          ),
        ),
      );
    }
  }

  void _submitAvis() {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('dd/MM/yyyy').format(now);

    context.read<AvisClientsBloc>().add(
      AddAvisClientEvent(
        id: now.millisecondsSinceEpoch.toString(),
        categories: categoriesController.text,
        text: textController.text,
        firstname: firstnameController.text,
        publishDate: now,
      ),
    );
    // Redirection après l'ajout de l'avis
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Avis ajouté avec succès')),
    );

    // Redirection vers la HomePage avec GoRouter
    context.go('/');
  }
}