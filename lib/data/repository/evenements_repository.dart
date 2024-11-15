import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:le_cocon_ssbe/data/dto/evenements_dto.dart';
import '../../domain/entities/evenements.dart';

abstract class EvenementRepository {
  FirebaseFirestore get firestore;

  Stream<Iterable<Evenement>> getEvenementStream();
  Future<EvenementDto?>getById(String evenementId);
}