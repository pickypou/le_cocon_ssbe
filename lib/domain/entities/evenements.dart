import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/utils/date_converter.dart';

class Evenements {
  final String title;
  final String id;
  String? fileUrl;
  String? fileType;
  String? thumbnailUrl;
  final DateTime publishDate;

  Evenements(
      {required this.title,
      required this.id,
      required this.fileType,
      required this.fileUrl,
      required this.publishDate,
      this.thumbnailUrl});

  ImageProvider<Object> getThumbnailImage() {
    if (thumbnailUrl != null && thumbnailUrl!.isNotEmpty) {
      return NetworkImage(thumbnailUrl!);
    } else {
      // Utiliser une image par défaut si la vignette n'existe pas
      return AssetImage('assets/images/logo_cocon.pbg');
    }
  }

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
