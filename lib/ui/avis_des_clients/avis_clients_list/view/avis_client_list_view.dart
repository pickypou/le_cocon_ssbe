import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/avis_clients.dart';
import '../../../common/widget/text_custom.dart';

class AvisClientsListView extends StatelessWidget {
  final List<AvisClients> avis;
  final String backgroundImage;

  const AvisClientsListView({
    super.key,
    required this.avis,
    required this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image en arrière-plan avec transparence
        Positioned.fill(
          child: Opacity(
            opacity:
                0.4, // Ajustez la transparence ici (0.0 = transparent, 1.0 = opaque)
            child: Image.asset(
              backgroundImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            CustomText(
              phrase: 'Les, Clients, Nous, Donnent, Leurs, Avis',
            ),
            const SizedBox(
                height: 16), // Espacement entre le texte et le carrousel
            CarouselSlider(
              items: avis.map((avisClient) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      avisClient.text,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black,
                            // fontWeight: FontWeight.bold,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                height: 200, // Hauteur du carrousel
                autoPlay: true, // Lecture automatique
                autoPlayInterval:
                    const Duration(seconds: 5), // Temps d’affichage prolongé
                enlargeCenterPage: true, // Mettre l'élément centré en avant
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true, // Boucle infinie
                scrollPhysics: const BouncingScrollPhysics(), // Effet fluide
              ),
            ),
          ],
        ),
      ],
    );
  }
}
