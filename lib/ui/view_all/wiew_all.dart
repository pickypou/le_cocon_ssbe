import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/common/widget/custom_appbar/custom_appbar.dart';
import 'package:le_cocon_ssbe/ui/common/widget/footer.dart';
import 'package:le_cocon_ssbe/ui/contact/contact_view.dart';
import 'package:le_cocon_ssbe/ui/espace_bien_etre/espace_bien_etre_view.dart';
import 'package:le_cocon_ssbe/ui/espace_sport/espace_sport_view.dart';
import 'package:le_cocon_ssbe/ui/evenements/evenement_view/evenement_view.dart';
import 'package:le_cocon_ssbe/ui/presentation/presentation.dart';
import '../avis_des_clients/view/avis_clients_view.dart';
import '../common/widget/header.dart';
import '../common/widget/img_header.dart';
import '../common/widget/text_presentation.dart';
import '../theme.dart';

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
              EvenementView(key: evenement),
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
