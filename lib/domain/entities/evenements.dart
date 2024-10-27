
import 'package:intl/intl.dart';

import '../../core/utils/date_converter.dart';

class Evenements {
  final String title;
  final String id;
  final String fileUrl;
  final String fileType;
  final DateTime publishDate;


  Evenements({
    required this.title,
    required this.id,
    required this.fileType,
    required this.fileUrl,
    required this.publishDate
  });



  factory Evenements.fromMap(Map<String, dynamic>? data, String id) {
    return Evenements(
        id: id,
      title: data?['title'] ?? 'Titre inconnu',
      fileType: data?['fileType'] ?? 'Type inconnu',
      fileUrl: data?['fileUrl'] ?? 'URL inconnue',
        publishDate:DateConverter.converToDateTime( data? ['publishDATE']),

    );
  }

  //Formatte la date au format (DD/MM/YYYY)
  String get formattedPublishDate {
    return DateFormat('dd/MM/yyyy').format(publishDate);
  }

  @override
  String toString() {
    return 'Evenements(id: $id, title: $title, fileType: $fileType, fileUrl: $fileUrl, publishDate: $formattedPublishDate)';
  }
}