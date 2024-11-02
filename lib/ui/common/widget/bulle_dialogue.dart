import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';
import '../../theme.dart';

class BulleDialogue extends StatelessWidget {
  final Color color;
  final String text;
  final double width;
  final double height;
  final double textXOffset;
  final double textYOffset;

  const BulleDialogue(
      {super.key,
      required this.text,
      this.width = 230,
      this.height = 150,
      this.textXOffset = 0,
      this.textYOffset = -20,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: SvgCustomPainter(
          config: BubbleConfig(
            borderColor: color,
            fillColor: Colors.transparent,
            text: text,
            textStyle:
                textStyleTextBulle(context),
            width: width,
            height: height,
            textXOffset: textXOffset,
            textYOffset: textYOffset,
          ),
        ),
      ),
    );
  }
}
