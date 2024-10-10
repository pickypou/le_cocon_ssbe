import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

class ImgHeader extends StatelessWidget {
  ImgHeader({super.key});

  final List<String> images = [
    'assets/images/img_header_1.jpeg',
    'assets/images/img_header_2.png',
    'assets/images/img_header_3.jpeg',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    if (size.width < 750) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: ImageSlider(
          imagePaths: images,
          useFadeTransition: true,
          duration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
          width: 300,
        ),
      );
    } else if (size.width < 1121) {
      return Padding(
          padding: const EdgeInsets.all(20),
          child: ImageCarousel(
            imageUrl: images,
            height: 350,
            fraction: 1,
            autoPlay: true,
            isFromAssets: true,
          ));
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5), // Couleur de l'ombre
                  spreadRadius: 2, // Élargissement de l'ombre
                  blurRadius: 8, // Flou de l'ombre
                  offset: const Offset(4, 4), // Position de l'ombre
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/img_header_1.jpeg',
              fit: BoxFit.contain,
              width: 350,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/img_header_2.png',
              fit: BoxFit.contain,
              width: 350,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 8,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Image.asset(
              'assets/images/img_header_3.jpeg',
              fit: BoxFit.contain,
              width: 350,
            ),
          ),
        ],
      );
    }
  }
}
