import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/common/widget/custom_appbar/custom_appbar.dart';
import 'package:le_cocon_ssbe/ui/common/widget/footer.dart';
import 'package:le_cocon_ssbe/ui/contact/contact_view.dart';
import 'package:le_cocon_ssbe/ui/espace_bien_etre/espace_bien_etre_view.dart';
import 'package:le_cocon_ssbe/ui/espace_sport/espace_sport_view.dart';
import 'package:le_cocon_ssbe/ui/presentation/presentation.dart';
import '../avis_des_clients/avis_clients_list/view/avis_clients_view.dart';
import '../common/widget/header.dart';
import '../common/widget/img_header.dart';
import '../common/widget/text_presentation.dart';
import '../evenements/evenement_view/evenement_list_view.dart'; // Assurez-vous d'importer EvenementListView pour afficher la liste d'événements
import '../theme.dart';
import '../../domain/entities/evenements.dart';

class ViewAll extends StatelessWidget {
  final GlobalKey espaceBienEtre = GlobalKey();
  final GlobalKey espaceSport = GlobalKey();
  final GlobalKey commenters = GlobalKey();
  final GlobalKey evenement = GlobalKey();
  final GlobalKey contact = GlobalKey();

  ViewAll({super.key});

  void _scrollToSection(String sectionId) {
    GlobalKey? key;
    switch (sectionId) {
      case 'espace_bien_etre':
        key = espaceBienEtre;
        break;
      case 'espace_sport':
        key = espaceSport;
        break;
      case 'commenters':
        key = commenters;
        break;
      case 'evenement':
        key = evenement;
        break;
      case 'contact':
        key = contact;
        break;
    }

    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        onNavigate: _scrollToSection,
        actions: const [],
      ),
      drawer: size.width < 749
          ? CustomDrawer(
        espaceBienEtre: espaceBienEtre,
        espaceSport: espaceSport,
        commenters: commenters,
        evenement: evenement,
        contact: contact,
      )
          : null,
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          color: theme.primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Header(),
              const SizedBox(height: 50),
              ImgHeader(),
              const SizedBox(height: 50),
              const TextPresentation(),
              const Presentation(),
              Image.asset('assets/images/divider_2.png'),
              EspaceBienEtreView(key: espaceBienEtre),
              Image.asset('assets/images/divider_2.png'),
              EspaceSportView(key: espaceSport),
              Image.asset('assets/images/divider_2.png'),
              AvisClientsView(key: commenters),
              const SizedBox(height: 50),
              Image.asset('assets/images/divider_2.png'),

              // Utilisation de StreamBuilder pour récupérer et afficher les événements
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('evenement')
                    .orderBy('publishDate', descending: true)
                    .limit(8)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Erreur : ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('Aucun événement disponible'));
                  }

                  List<Evenements> evenementsList = snapshot.data!.docs
                      .map((doc) => Evenements.fromMap(
                    doc.data() as Map<String, dynamic>,
                    doc.id,
                  ))
                      .toList();

                  return const EvenementListView( evenements: [],);
                },
              ),
              Image.asset('assets/images/divider_2.png'),
              ContactView(key: contact),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
