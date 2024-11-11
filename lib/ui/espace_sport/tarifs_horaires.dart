import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';
import '../common/widget/markdown_viewer.dart';

class TarifsHoraires extends StatelessWidget {
  final double fraction;
  final Size size;

  const TarifsHoraires({super.key, required this.fraction, required this.size});

  @override
  Widget build(BuildContext context) {
    return OrientationSizeBox(
      size: size,
      fraction: fraction,
      child: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        alignment: WrapAlignment.center,
        children: [
          buildMarkdownCard('assets/markdown/horaires.md', context),
          buildMarkdownCard('assets/markdown/tarifs.md', context),
        ],
      ),
    );
  }

  Widget buildMarkdownCard(String filePath, BuildContext context) {
    return Wrap(children: [
      Card(
        margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: size.width * 0.6, // Ajuste la largeur des cartes
          height: size.height * 0.60,
          child: MarkdownViewer(filePath: filePath),
        ),
      )
    ]);
  }
}
