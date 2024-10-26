import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/domain/entities/evenements.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class EvenementView extends StatelessWidget {
  final Evenements evenement;

  const EvenementView({super.key, required this.evenement});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          evenement.fileType,
          style: titleStyleMedium(context),
        ),
        Text(
          evenement.formattedPublishDate,
          style: titleStyleSmall(context),
        ),
        GestureDetector(
          onTap: () => _showEnlargedView(context),
          child: SizedBox(
            width: 100,
            height: 100,
            child: _buildThumbnail(),
          ),
        ),
      ],
    );
  }

  Widget _buildThumbnail() {
    if (evenement.fileType.toLowerCase() == 'pdf') {
      return PdfDocumentLoader.openFile(
        evenement.fileUrl,
        pageNumber: 1,
        pageBuilder: (context, textureBuilder, pageSize) => textureBuilder(),
      );
    } else {
      return Image.network(
        evenement.fileUrl,
        fit: BoxFit.cover,
      );
    }
  }

  void _showEnlargedView(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: evenement.fileType.toLowerCase() == 'pdf'
                ? PdfDocumentLoader.openFile(
              evenement.fileUrl,
              pageBuilder: (context, textureBuilder, pageSize) =>
                  textureBuilder(),
            )
                : Image.network(
              evenement.fileUrl,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}