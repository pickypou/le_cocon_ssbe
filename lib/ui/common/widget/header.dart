import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double titleFontSize = size.width / 11;
    if (size.width < 750) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo_cocon.png",
              fit: BoxFit.contain,
              width: 220,
            ),
            RichText(
              text: TextSpan(
                text: 'Le ', // Partie avec la police Amable
                style: titleStyleLarge(context).copyWith(
                  fontFamily:
                      'Amable', // Change la police tout en gardant les autres styles
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Cocon', // Partie avec la police Autography
                    style: titleStyleLarge(context).copyWith(
                        fontFamily: 'Autography', fontSize: titleFontSize
                        // Change uniquement la police
                        ),
                  ),
                  TextSpan(
                    text: 'S.S.B.E', // Partie avec la police Autography
                    style: titleStyleMedium(context).copyWith(
                        fontFamily: 'Autography', fontSize: titleFontSize,),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } if (size.width < 1123) {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo_cocon.png",
                fit: BoxFit.contain,
                width: 200,
              ),
              RichText(
                text: TextSpan(
                  text: 'Le ', // Partie avec la police Amable
                  style: titleStyleLarge(context).copyWith(
                    fontFamily:
                    'Amable', // Change la police tout en gardant les autres styles
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Cocon', // Partie avec la police Autography
                      style: titleStyleLarge(context).copyWith(
                          fontFamily: 'Autography', fontSize: titleFontSize
                        // Change uniquement la police
                      ),
                    ),
                    TextSpan(
                      text: 'S.S.B.E', // Partie avec la police Autography
                      style: titleStyleLarge(context).copyWith(
                          fontFamily: 'Autography', fontSize: titleFontSize),
                    ),
                  ],
                ),
              )
            ]),
      );
    }else {
      return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo_cocon.png",
                fit: BoxFit.contain,
                width: 300,
              ),
              RichText(
                text: TextSpan(
                  text: 'Le ', // Partie avec la police Amable
                  style: titleStyleLarge(context).copyWith(
                    fontFamily:
                        'Amable', // Change la police tout en gardant les autres styles
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Cocon', // Partie avec la police Autography
                      style: titleStyleLarge(context).copyWith(
                          fontFamily: 'Autography', fontSize: titleFontSize
                          // Change uniquement la police
                          ),
                    ),
                    TextSpan(
                      text: 'S.S.B.E', // Partie avec la police Autography
                      style: titleStyleLarge(context).copyWith(
                          fontFamily: 'Autography', fontSize: titleFontSize),
                    ),
                  ],
                ),
              )
            ]),
      );
    }
  }
}
