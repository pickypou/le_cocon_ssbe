import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../common/widget/custom_button.dart';
import '../../common/widget/custom_text_field.dart';
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
  final TextEditingController publishDateController = TextEditingController();

  @override
  void dispose() {
    categoriesController.dispose();
    textController.dispose();
    firstnameController.dispose();
    publishDateController.dispose();
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
          Navigator.pop(context);
        } else if (state is AvisClientsErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('J\'ajoute un avis'),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
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
              Text(
                'Ajouter un commentaire',
                style: titleStyleLarge(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              CustomTextField(
                labelText: 'Titre',
                controller: categoriesController,
                maxLines: 1,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: 'Date du jour (dd/MM/yyyy)',
                controller: publishDateController,
                maxLines: 1,
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
    try {
      final DateFormat format = DateFormat('dd/MM/yyyy');
      final DateTime publishDate = format.parse(publishDateController.text);

      context.read<AvisClientsBloc>().add(
        AddAvisClientEvent(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          categories: categoriesController.text,
          text: textController.text,
          publishDate: publishDate,
          firstname: firstnameController.text,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de format de date : $e')),
      );
      debugPrint('Erreur de format de date : $e');
    }
  }
}

