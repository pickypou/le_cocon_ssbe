import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

import '../../../../domain/entities/avis_clients.dart';

class AvisClientsListView extends StatefulWidget {
  final List<AvisClients> avis;
  final String backgroundImage;

  const AvisClientsListView({
    super.key,
    required this.avis,
    required this.backgroundImage,
  });

  @override
  State<AvisClientsListView> createState() => _AvisClientsListViewState();
}

class _AvisClientsListViewState extends State<AvisClientsListView> {
  final CarouselSliderController _carouselController = CarouselSliderController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    bool isSmallScreen = size.width < 749;

    // ** Styles dynamiques **
    double paddingHorizontal = isSmallScreen ? 20 : 90;
    double imageOpacity = isSmallScreen ? 0.4 : 0.2;
    double carouselHeight = isSmallScreen ? 450 : 300;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 40 : 55),
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Opacity(
              opacity: imageOpacity,
              child: Image.asset(
                widget.backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main content
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Carousel slider
              Stack(
                alignment: Alignment.center,
                children: [
                  CarouselSlider(
                    items: widget.avis.map((avis) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                        child: SizedBox(
                          height: 600,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Guillemets arrondis
                              Text(
                                '“',
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 5),

                              // Texte avec gestion du dépassement
                              Flexible(
                                child: Text(
                                  avis.text,
                                  style:textStyleText(context).copyWith(
                                    color: Colors.black,
                                    fontSize: isSmallScreen ? 14 : 16, // Ajuste la taille
                                    //fontStyle: FontStyle.italic,
                                  ),
                                  textAlign: TextAlign.center,
                                //  maxLines: isSmallScreen ? 4 : null, // Limite les lignes
                                  //overflow: TextOverflow.ellipsis,    // Points de suspension
                                ),
                              ),

                              const SizedBox(height: 5),

                              // Nom de l'auteur
                              Text(
                                avis.firstname,
                                style: textStyleText(context).copyWith(
                                  color: Colors.black,
                                  //fontStyle: FontStyle.italic,
                                  fontSize: isSmallScreen ? 14 : 16, // Ajuste la taille
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                DateFormat('dd MMMM yyyy').format(avis.publishDate),
                                style: textStyleText(context).copyWith(
                                  color: Colors.black,
                                  fontSize: isSmallScreen ? 14 : 14, // Ajuste la taille
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );

                    }).toList(),
                    options: CarouselOptions(
                      height: carouselHeight,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 15),
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    carouselController: _carouselController,
                  ),

                  // Left navigation button
                  Positioned(
                    left: 0,
                    child: IconButton(
                      icon: const Icon(Icons.chevron_left,
                          color: Colors.black, size: 40),
                      onPressed: () {
                        _carouselController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
                      },
                    ),
                  ),

                  // Right navigation button
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.chevron_right,
                          color: Colors.black, size: 40),
                      onPressed: () {
                        _carouselController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.avis.asMap().entries.map((entry) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(
                          _currentIndex == entry.key ? 0.9 : 0.4),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
