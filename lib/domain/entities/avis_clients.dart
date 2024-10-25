import 'package:intl/intl.dart';

import '../../core/utils/date_converter.dart';

class AvisClients {
  final String id;
  final String categories;
  final String text;
  final DateTime publishDate;

  AvisClients({
    required this.id,
    required this.categories,
    required this.text,
    required this.publishDate
  });

  factory AvisClients.fromMap(Map<String, dynamic>? data, String id) {
    return AvisClients(
      id: id,
      categories: data?['categories'] ?? '',
      text: data? ['text'] ?? '',
      publishDate: DateConverter.converToDateTime(data? ['publishDate']), // Utilise le convertisseur ici
    );
  }
  //Formatte la date au format (DD/MM/YYYY)
  String get formattedPublishDate {
    return DateFormat('dd/MM/yyyy').format(publishDate);
  }
}