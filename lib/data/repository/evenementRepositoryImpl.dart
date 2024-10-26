import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:le_cocon_ssbe/data/repository/enements_repository.dart';
import 'package:le_cocon_ssbe/domain/entities/evenements.dart';

@injectable

class EvenementRepositoryImpl extends EvenementRepository {
  final FirebaseFirestore _firestore;
  
  EvenementRepositoryImpl({FirebaseFirestore? firestore})
  : _firestore = firestore ?? FirebaseFirestore.instance;
  
  @override
  FirebaseFirestore get firestore => _firestore;
  
  @override
  Stream<Iterable<Evenements>> getEvenementStream() {
    return _firestore.collection('evenement').snapshots().map(
          (querySnapshot) =>
          querySnapshot.docs
              .map((doc) => Evenements.fromMap(doc.data(), doc.id))
              .toList(),
    );
  }

    @override

    Future<Map<String, dynamic>> getById(String evenementId) async {
    final docSnapshot =
        await _firestore.collection('evenement').doc(evenementId).get();
    return docSnapshot.data() ?? {};
    }



}