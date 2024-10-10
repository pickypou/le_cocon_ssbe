import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';
import '../../theme.dart';

class BulleAvisClients extends StatelessWidget {
  final Color color;
  final String date;
  final String categories;
  final String text;

  const BulleAvisClients({
    Key? key,
    required this.text,
    required this.color,
    required this.date,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Combine all texts (category, date, review text) into a single string
    String fullText = '$date\n$categories\n\n$text';

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate the bubble size based on the text size
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: fullText,
            style: textStyleTextBulle(context).copyWith(
              fontSize: size.width / 80,
              fontWeight: FontWeight.normal,
            ),
          ),
          textDirection: TextDirection.ltr,
          maxLines: null, // Allow text to take multiple lines
        );

        // Calculate the dimensions needed to draw the bubble
        textPainter.layout(maxWidth: constraints.maxWidth * 0.9);  // Adjust the max width of the bubble
        double bubbleWidth = textPainter.width + 25;  // Add margin on each side
        double bubbleHeight = textPainter.height + 100;  // Add margin on top and bottom, plus extra space for the tail

        return Center(
          child: CustomPaint(
            painter: BubblePainter(
              color: color,
              bubbleWidth: bubbleWidth,
              bubbleHeight: bubbleHeight,
            ),
            child: Container(
              width: bubbleWidth,
              height: bubbleHeight,
              padding: const EdgeInsets.all(10), // Adjust padding for more space
              child: Text(
                fullText,
                style: textStyleTextBulle(context).copyWith(
                  fontSize: size.width / 70,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,  // Center the text
              ),
            ),
          ),
        );
      },
    );
  }
}

class BubblePainter extends CustomPainter {
  final Color color;
  final double bubbleWidth;
  final double bubbleHeight;

  BubblePainter({
    required this.color,
    required this.bubbleWidth,
    required this.bubbleHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke; // Remplir la bulle avec la couleur

    final path = Path();

    // Dessiner la bulle avec des coins arrondis
    path.moveTo(10, 0); // Coin supérieur gauche

    path.lineTo(bubbleWidth - 10, 0); // Haut
    path.quadraticBezierTo(bubbleWidth, 0, bubbleWidth, 10); // Coin supérieur droit

    path.lineTo(bubbleWidth, bubbleHeight - 10); // Droite
    path.quadraticBezierTo(bubbleWidth, bubbleHeight, bubbleWidth - 10, bubbleHeight); // Coin inférieur droit

    path.lineTo(10, bubbleHeight); // Bas droit
    path.quadraticBezierTo(0, bubbleHeight, 0, bubbleHeight - 10); // Coin inférieur gauche

    path.lineTo(0, 10); // Gauche
    path.quadraticBezierTo(0, 0, 10, 0); // Coin supérieur gauche (fermer le chemin)

    // Dessiner le chemin de la bulle
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

