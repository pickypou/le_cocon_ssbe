import 'package:intl/intl.dart';

import '../../core/utils/date_converter.dart';

class Evenements {
  final String title;
  final String id;
  String fileUrl;
  final String fileType;
  String? thumbnailUrl;
  final DateTime publishDate;

  Evenements(
      {required this.title,
      required this.id,
      required this.fileType,
      required this.fileUrl,
      required this.publishDate,
      this.thumbnailUrl});

  bool get isPdfFile => fileUrl.endsWith('.pdf');

  factory Evenements.fromMap(Map<String, dynamic>? data, String id) {
    return Evenements(
      id: id,
      title: data?['title'] ?? 'Titre inconnu',
      fileType: data?['fileType'] ?? 'Type inconnu',
      fileUrl: data?['fileUrl'] ?? 'URL inconnue',
      thumbnailUrl: data?['thumbnailUrl'] ?? '',
      publishDate: DateConverter.converToDateTime(data?['publishDATE']),
    );
  }

  //Formatte la date au format (DD/MM/YYYY)
  String get formattedPublishDate {
    return DateFormat('dd/MM/yyyy').format(publishDate);
  }

  @override
  String toString() {
    return 'Evenements(id: $id, title: $title, fileType: $fileType, fileUrl: $fileUrl, thumbnailUrl: $thumbnailUrl, publishDate: $formattedPublishDate)';
  }
}
