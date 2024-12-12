import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../common/widget/custom_button.dart';
import '../../../common/widget/custom_text_field.dart';
import '../../../theme.dart';
import '../../avis_clients_bloc.dart';
import '../../avis_clients_event.dart';
import '../../avis_clients_state.dart';

class AddAvisClientsView extends StatelessWidget {
  final TextEditingController categoriesController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController publishDateController = TextEditingController();

  AddAvisClientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AvisClientsBloc, AvisClientsState>(
      builder: (context, state) {
        if (state is AvisClientsLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AvisClientsErrorState) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          );
        } else if (state is AddAvisClientsSignUpSuccessState) {
          return _buildForm(context, state.addAvisClientsId);
        } else {
          return _buildForm(context, '');
        }
      },
    );
  }

  Widget _buildForm(BuildContext context, String adherentId) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('J\'ajoute un avis'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/'); // Revenir à la page précédente
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Ajouter un commentaire',
                style: titleStyleLarge(context),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 40.0,
                runSpacing: 20.0,
                children: [
                  CustomTextField(
                    labelText: 'Titre',
                    controller: categoriesController,
                    maxLines: 1,
                  ),
                  const SizedBox(width: 40),
                  CustomTextField(
                    labelText: 'Date du jour (dd/MM/yyyy)',
                    controller: publishDateController,
                    maxLines: 1,
                  ),
                  CustomTextField(
                    labelText: 'Mon commentaire',
                    controller: textController,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      try {
                        DateFormat format = DateFormat('dd/MM/yyyy');
                        DateTime publishDate =
                        format.parse(publishDateController.text);

                        context.read<AvisClientsBloc>().add(
                          AddAvisClientEvent(
                            id: 'someId', // Remplacez par un vrai ID si nécessaire
                            categories: categoriesController.text,
                            text: textController.text,
                            publishDate: publishDate,
                            firstname: firstnameController.text,
                            navigateToAccount: () =>
                               Navigator.pop(context),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Erreur de format de date : $e'),
                          ),
                        );
                        debugPrint('Erreur de format de date : $e');
                      }
                    },
                    label: 'Je poste mon avis',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
