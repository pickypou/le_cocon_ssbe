import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

class Activities extends StatelessWidget {
  final String logo;
  final String title;
  final String text;
  final String value;
  final bool isImageBeforeTitle;

  const Activities({
    super.key,
    required this.title,
    required this.text,
    required this.value,
    this.isImageBeforeTitle = true,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double imageWidth = size.width * 0.18;
    double decalage = size.width * 0.1; // Augmentation du décalage

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: isImageBeforeTitle ? 0 : decalage), // Décalage conditionnel
              if (isImageBeforeTitle) ...[
                Image.asset(
                  'assets/images/$value',
                  fit: BoxFit.contain,
                  width: imageWidth,
                ),
                const SizedBox(width: 20),
              ],
              Image.asset(
                'assets/images/$logo',
                fit: BoxFit.contain,
                width: imageWidth * 0.5,
              ),
              const SizedBox(width: 20),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: titleStyleSmall(context).copyWith(fontSize: size.width / 35),
                    ),
                    const SizedBox(height: 05),
                    Text(
                      text,
                      style: textStyleText(context)
                    ),
                  ],
                ),
              ),
              if (!isImageBeforeTitle) ...[
                const SizedBox(width: 20),
                Image.asset(
                  'assets/images/$value',
                  fit: BoxFit.contain,
                  width: imageWidth,
                ),
              ],
              SizedBox(width: isImageBeforeTitle ? decalage : 0), // Décalage conditionnel
            ],
          ),
        ],
      ),
    );
  }
}