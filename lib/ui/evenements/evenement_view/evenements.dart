import 'package:cloud_firestore/cloud_firestore.dart';

class Evenements {
  final String id;
  final String title;
  final DateTime publishDate;

  Evenements({required this.id, required this.title, required this.publishDate});

  factory Evenements.fromMap(Map<String, dynamic> data, String documentId) {
    return Evenements(
      id: documentId,
      title: data['title'] ?? 'Sans titre',
      publishDate: (data['publishDate'] as Timestamp).toDate(),
    );
  }
}
