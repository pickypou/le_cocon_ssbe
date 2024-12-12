import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

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
  final CarouselSliderControllerImpl _carouselController =
      CarouselSliderControllerImpl();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    if (size.width < 749) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
    child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.4,
              child: Image.asset(
                widget.backgroundImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CarouselSlider(
                      items: widget.avis.asMap().entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            entry.value.text,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        height: 450,
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
                    Positioned(
                      left: 0,
                      child: IconButton(
                        icon: const Icon(Icons.chevron_left,
                            color: Colors.black, size: 40),
                        onPressed: () {
                          _carouselController.nextPage();
                        },
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.chevron_right,
                            color: Colors.black, size: 40),
                        onPressed: () {
                          _carouselController.previousPage();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.avis.asMap().entries.map((entry) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black
                          .withOpacity(_currentIndex == entry.key ? 0.9 : 0.4),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
    )
      );
    } else {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 55),
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    widget.backgroundImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CarouselSlider(
                        items: widget.avis.asMap().entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 90,),
                            child: Text(
                              entry.value.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 300,
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
                      Positioned(
                        left: 0,
                        child: IconButton(
                          icon: const Icon(Icons.chevron_left,
                              color: Colors.black, size: 40),
                          onPressed: () {
                            _carouselController.nextPage();
                          },
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.chevron_right,
                              color: Colors.black, size: 40),
                          onPressed: () {
                            _carouselController.previousPage();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
          ));
    }
  }
}
